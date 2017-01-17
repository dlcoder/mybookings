require 'rails_helper'

module Mybookings
  describe BookingsController do
    routes { Mybookings::Engine.routes }

    context 'when the user is not logged in' do
      describe 'on GET to index' do
        before { get :index }
        it { expect(response).to redirect_to(new_user_session_path) }
      end
    end

    context 'when the user is logged in' do
      let(:user) { mybookings_users(:user) }
      let(:resources) { [] }
      let(:bookings) { [] }
      let(:filtered_bookings) { double(by_start_date_group_by_resource_type: bookings) }
      let(:bookings_grouped_by_resource_type) { [] }

      before { sign_in(user) }

      describe 'on GET to index' do
        before do
          allow_any_instance_of(BookingPolicy::Scope).to receive(:resolve).and_return(filtered_bookings)
          allow(BookingDecorator).to receive(:decorate_collection).with(bookings).and_return(bookings)
          allow(filtered_bookings).to receive(:map).with({}).and_return(bookings_grouped_by_resource_type)

          get :index
        end

        it { expect(response).to render_template(:index) }
      end

      describe 'on GET to new_booking_resource_type_step' do
        let(:resource_types) { [] }

        before do
          allow(ResourceType).to receive(:all).and_return(resource_types)

          get :new_booking_resource_type_step
        end

        it { expect(response).to render_template(:new_booking_resource_type_step) }
      end


      describe 'on GET to new_booking_events_step' do
        let(:booking_id) { '1' }
        let(:resource_type) { ResourceType.new }
        let(:resources) { [] }
        let(:booking) { Booking.new }
        let(:events) { double(:build) }

        before do
          allow(ResourceType).to receive(:find).with(booking_id).and_return(resource_type)
          allow(Resource).to receive(:available_by_resource_type).and_return(resources)
          allow(Booking).to receive(:new).with(resource_type: resource_type).and_return(booking)
          allow(booking).to receive(:events).and_return(events)
          allow(events).to receive(:build)

          get :new_booking_events_step, booking_id: booking_id
        end

        it { expect(response).to render_template(:new_booking_events_step) }
      end

      describe 'on POST to create' do
        let(:booking_form) { BookingsForm.new }
        let(:resource_type) { ResourceType.new }
        let(:event) { Event.new }
        let(:booking) { Booking.new(user: user, events: [event], resource_type: resource_type) }

        before do
          allow(BookingsForm).to receive(:new).and_return(booking_form)
        end

        context 'when the booking form are not valid' do
          let(:resources) { [] }
          let(:resource_type) { ResourceType.new }

          before do
            allow(booking_form).to receive(:valid?).and_return(false)
            allow(booking_form).to receive(:resource_type).and_return(resource_type)
            allow(Resource).to receive(:available_by_resource_type).with(resource_type).and_return(resources)

            post :create, booking: { }
          end

          it { expect(response).to render_template(:new_booking_events_step) }
        end

        context 'when the booking params are valid' do

          context 'when the booking is not valid' do
            let(:resources) { [] }
            let(:resource_type) { ResourceType.new }

            before do
              allow(booking_form).to receive(:valid?).and_return(false)
              allow(booking_form).to receive(:resource_type).and_return(resource_type)
              allow(Resource).to receive(:available_by_resource_type).with(resource_type).and_return(resources)

              post :create, booking: { }
            end

            it { expect(response).to render_template(:new_booking_events_step) }
          end

          context 'when the booking is valid' do
            let(:events) { [] }
            let(:event) { Event.new }
            let(:mail) { double(:deliver_now!) }

            before do
              allow(booking_form).to receive(:valid?).and_return(true)
              allow(booking_form).to receive(:type).and_return('')
              allow(CreatesBooking).to receive(:from_form).with(user, booking_form).and_return(booking)
              allow(booking).to receive(:valid?).and_return(true)
              allow(booking).to receive(:events).and_return(events)
              allow(ResourceTypesExtensionsWrapper).to receive(:call).with(:after_booking_creation, event)
              allow(booking).to receive(:save!).and_return(true)
              allow(NotificationsMailer).to receive(:notify_new_booking).with(booking).and_return(mail)
              allow(mail).to receive(:deliver_now!)

              post :create, bookings_form: { }
            end

            it { expect(response).to redirect_to(bookings_path) }
          end
        end
      end

      describe 'on DELETE to destroy' do
        let(:booking_id) { '1' }
        let(:booking) { Booking.new }

        before do
          allow(BookingDecorator).to receive(:find).with(booking_id).and_return(booking)
          allow_any_instance_of(BookingPolicy).to receive(:manage?).and_return(true)
        end

        context 'when the booking has events started' do
          before do
            allow(booking).to receive(:has_pending_events?).and_return(false)

            delete :destroy, id: booking_id
          end

          it { expect(response).to redirect_to(bookings_path) }
        end

        context 'when the booking has pending events' do
          let(:mail) { double(:deliver_now!) }

          before do
            allow(booking).to receive(:has_pending_events?).and_return(true)

            allow(NotificationsMailer).to receive(:notify_delete_booking).with(booking).and_return(mail)
            allow(mail).to receive(:deliver_now!)
            allow(booking).to receive(:delete_pending_events).and_return(booking)
          end

          context 'when the booking has any event yet' do
            before do
              allow(booking).to receive(:has_events?).and_return(true)
              expect(booking).not_to receive(:destroy)

              delete :destroy, id: booking_id
            end

            it { expect(response).to redirect_to(bookings_path) }
          end

          context 'when the booking has no events' do
            before do
              allow(booking).to receive(:has_events?).and_return(false)
              expect(booking).to receive(:destroy)

              delete :destroy, id: booking_id
            end

            it { expect(response).to redirect_to(bookings_path) }
          end

        end
      end
    end

  end
end

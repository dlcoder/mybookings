require 'rails_helper'

describe BookingsController do

  context 'when the user is not logged in' do
    describe 'on GET to index' do
      before { get :index }
      it { expect(response).to redirect_to(new_user_session_path) }
    end
  end

  context 'when the user is logged in' do
    let(:user) { users(:user) }
    let(:resources) { [] }
    let(:bookings) { [] }
    let(:filtered_bookings) { double(by_start_date_group_by_resource_type: bookings) }

    before { sign_in(user) }

    describe 'on GET to index' do
      before do
        allow_any_instance_of(BookingPolicy::Scope).to receive(:resolve).and_return(filtered_bookings)
        allow(filtered_bookings).to receive(:by_start_date).and_return(filtered_bookings)
        allow(filtered_bookings).to receive(:decorate).and_return(bookings)

        get :index
      end

      it { expect(response).to render_template(:index) }
    end

    describe 'on GET to new first step' do

      before do

        get :new_booking_resource_type_step
      end

      it { expect(response).to render_template(:new_booking_resource_type_step) }
    end

    describe 'on POST to create' do
      let(:resource_type) { resource_types(:pcv) }
      let(:booking_params) { { "resource_type_id" => "#{resource_type.id}", "events" => {"resource_id" => "1", "start_date" => ''} } }
      let(:event) { events(:event1) }
      let(:booking) { Booking.new(user: user, events: [event], resource_type: resource_type) }

      before do
        allow(Booking).to receive(:new_for_user).with(user, booking_params).and_return(booking)
      end

      context 'when the booking params is valid' do
        let(:resource_type_extension) { '' }

        before do
          allow(booking).to receive(:valid?).and_return(true)
          allow(booking).to receive(:resource_type_extension).and_return(resource_type_extension)
          allow(ResourceTypesExtensionsWrapper).to receive(:call).with(:after_booking_creation, booking.events.first)
          allow(booking).to receive(:save!).and_return(true)

          post :create, booking: booking_params
        end

        it { expect(response).to redirect_to(bookings_path) }
      end

      context 'when the booking params is not valid' do
        let(:resources) { [] }
        let(:resource_type) { ResourceType.new }

        before do
          allow(booking).to receive(:valid?).and_return(false)
          allow(Resource).to receive(:available_by_resource_type).with(resource_type).and_return(resources)

          post :create, booking: booking_params
        end

        it { expect(response).to render_template(:new_booking_events_step) }
      end
    end

    describe 'on DELETE to destroy' do
      let(:event) { events(:event1) }
      let(:resource_type) { resource_types(:pcv) }
      let(:booking_id) { '1' }
      let(:booking) { Booking.new(user: user, events: [event], resource_type: resource_type) }

      before do
        allow(BookingDecorator).to receive(:find).with(booking_id).and_return(booking)
      end

      context 'when the booking has events started' do
        before do
          allow(event).to receive(:pending?).and_return(false)
          expect(booking).to_not receive(:destroy)

          delete :destroy, id: booking_id
        end

        it { expect(response).to redirect_to(bookings_path) }
      end

      context 'when the booking has events not started' do
        before do
          allow(event).to receive(:pending?).and_return(true)
          allow(booking).to receive(:has_pending_events?).and_return(true)
          allow(booking).to receive(:has_events?).and_return(false)
          expect(booking).to receive(:destroy)

          delete :destroy, id: booking_id
        end

        it { expect(response).to redirect_to(bookings_path) }
      end
    end
  end

end

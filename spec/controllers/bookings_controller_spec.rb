require 'spec_helper'

describe BookingsController do

  context 'when the user is not logged in' do
    describe 'on GET to index' do
      before { get :index }
      it { expect(page).to redirect_to(new_user_session_path) }
    end
  end

  context 'when the user is logged in' do
    let(:user) { users(:user) }
    let(:resources) { [] }
    let(:bookings) { [] }
    let(:filtered_bookings) { double(by_start_date: bookings) }

    before { sign_in(user) }

    describe 'on GET to index' do
      before do
        allow_any_instance_of(BookingPolicy::Scope).to receive(:resolve).and_return(filtered_bookings)
        allow(bookings).to receive(:decorate).and_return(bookings)

        get :index
      end

      it { expect(assigns[:bookings]).to eq(bookings) }
      it { expect(page).to render_template(:index) }
    end

    describe 'on GET to new first step' do

      before do

        get :new_first_step
      end

      it { expect(assigns[:resource_types]).to be_a(ActiveRecord::Relation) }
      it { expect(:resource_types).to have_at_least(1).item }
      it { expect(page).to render_template(:new_first_step) }
    end

    describe 'on POST to create' do
      let(:booking_params) { { "resource_type_id" => 1, "events" => {"resource_id" => 1, "start_date" => ''} } }
      let(:booking) { Booking.new }

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

        it { expect(assigns[:booking]).to be_a(Booking) }
        it { expect(page).to redirect_to(bookings_path) }
      end

      context 'when the booking params is not valid' do
        let(:resources) { [] }

        before do
          allow(booking).to receive(:valid?).and_return(false)
          allow(Resource).to receive(:avalaible_by_type_name_and_name).and_return(resources)

          post :create, booking: booking_params
        end

        it { expect(assigns[:resources]).to eq(resources) }
        it { expect(assigns[:booking]).to be_a(Booking) }
        it { expect(page).to render_template(:new) }
      end
    end

    describe 'on DELETE to destroy' do
      let(:event) { Event.new(start_date: '') }
      let(:booking_id) { '1' }
      let(:booking) { Booking.new(user: user, events: [event]) }

      before do
        allow(BookingDecorator).to receive(:find).with(booking_id).and_return(booking)
      end

      context 'when the booking has started' do
        before do
          allow(event).to receive(:pending?).and_return(false)
          expect(booking).to_not receive(:destroy)

          delete :destroy, id: booking_id
        end

        it { expect(page).to redirect_to(bookings_path) }
      end

      context 'when the booking have not started' do
        before do
          allow(event).to receive(:pending?).and_return(true)
          expect(booking).to receive(:destroy)

          delete :destroy, id: booking_id
        end

        it { expect(page).to redirect_to(bookings_path) }
      end
    end

    describe 'on GET to edit_feedback' do
      let(:booking_id) { '1' }
      let(:booking) { Booking.new(user: user) }

      before do
        allow(BookingDecorator).to receive(:find).with(booking_id).and_return(booking)

        get :edit_feedback, booking_id: booking_id
      end

      it { expect(page).to render_template(:edit_feedback) }
    end

    describe 'on PUT to set_feedback' do
      let(:booking_id) { '1' }
      let(:booking) { Booking.new(user: user) }
      let(:feedback) { '' }

      before do
        allow(BookingDecorator).to receive(:find).with(booking_id).and_return(booking)
        allow(booking).to receive(:feedback=).with(feedback)
        allow(booking).to receive(:save!)

        put :set_feedback, booking_id: booking_id, booking: { feedback: feedback }
      end

      it 'saves feedback' do
      end

      it { expect(page).to redirect_to(bookings_path) }
    end
  end

end

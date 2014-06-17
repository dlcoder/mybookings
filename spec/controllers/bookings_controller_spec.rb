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

        get :index
      end

      it { expect(assigns[:bookings]).to eq(bookings) }
      it { expect(page).to render_template(:index) }
    end

    describe 'on GET to new' do
      before do
        allow(Resource).to receive(:available).and_return(resources)

        get :new
      end

      it { expect(assigns[:resources]).to eq(resources) }
      it { expect(assigns[:booking]).to be_a(Booking) }
      it { expect(page).to render_template(:new) }
    end

    describe 'on POST to create' do
      let(:booking_params) { { "start_date" => '' } }
      let(:booking) { Booking.new }

      before do
        allow(Booking).to receive(:create_for_user).with(user, booking_params).and_return(booking)
      end

      context 'when the booking params is valid' do
        before do
          expect(booking).to receive(:valid?).and_return(true)

          post :create, booking: booking_params
        end

        it { expect(page).to redirect_to(bookings_path) }
      end

      context 'when the booking params is not valid' do
        let(:resources) { [] }

        before do
          expect(booking).to receive(:valid?).and_return(false)
          allow(Resource).to receive(:available).and_return(resources)

          post :create, booking: booking_params
        end

        it { expect(assigns[:resources]).to eq(resources) }
        it { expect(assigns[:booking]).to be_a(Booking) }
        it { expect(page).to render_template(:new) }
      end
    end

    describe 'on DELETE to destroy' do
      let(:booking_id) { '1' }
      let(:booking) { Booking.new(user: user) }

      before do
        allow(Booking).to receive(:find).with(booking_id).and_return(booking)
        allow(booking).to receive(:destroy)

        delete :destroy, id: booking_id
      end

      it { expect(page).to redirect_to(bookings_path) }
    end

    describe 'on GET to edit_feedback' do
      let(:booking_id) { '1' }
      let(:booking) { Booking.new(user: user) }

      before do
        allow(Booking).to receive(:find).with(booking_id).and_return(booking)

        get :edit_feedback, booking_id: booking_id
      end

      it { expect(page).to render_template(:edit_feedback) }
    end

    describe 'on PUT to set_feedback' do
      let(:booking_id) { '1' }
      let(:booking) { Booking.new(user: user) }
      let(:feedback) { '' }

      before do
        allow(Booking).to receive(:find).with(booking_id).and_return(booking)
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

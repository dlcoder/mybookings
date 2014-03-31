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

    before { sign_in(user) }

    describe 'on GET to index' do
      before { get :index }

      it { expect(assigns[:current_user]).to eq(user) }
      it { expect(page).to render_template(:index) }
    end

    describe 'on GET to new' do
      let(:resources) { [] }

      before do
        allow(Resource).to receive(:all).and_return(resources)

        get :new
      end

      it { expect(assigns[:resources]).to eq(resources) }
      it { expect(assigns[:booking]).to be_a(Booking) }
      it { expect(page).to render_template(:new) }
    end

    describe 'on POST to create' do
      let(:booking) { Booking.new }
      let(:resource) { Resource.new }

      before do
        allow(BookingsController::BookingParams).to receive(:build)
        allow(Booking).to receive(:new).and_return(booking)
        allow(Resource).to receive(:find).and_return(resource)
      end

      context 'when the booking is not valid' do
        before do
          allow(booking).to receive(:save!).and_return(false)

          post :create, booking: {}
        end

        it { expect(assigns[:booking]).to be_a(Booking) }
        it { expect(page).to render_template(:new) }
      end

      context 'when the booking is valid' do
        before do
          allow(booking).to receive(:save!).and_return(true)

          post :create, booking: {}
        end

        it { expect(page).to redirect_to(bookings_path) }
      end
    end
  end

end

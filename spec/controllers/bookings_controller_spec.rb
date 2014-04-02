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

    before { sign_in(user) }

    describe 'on GET to index' do
      before { get :index }

      it { expect(assigns[:current_user]).to eq(user) }
      it { expect(page).to render_template(:index) }
    end

    describe 'on GET to new' do
      before do
        allow(Resource).to receive(:all).and_return(resources)

        get :new
      end

      it { expect(assigns[:resources]).to eq(resources) }
      it { expect(assigns[:booking_form]).to be_a(BookingForm) }
      it { expect(page).to render_template(:new) }
    end

    describe 'on POST to create' do
      let(:booking_form_params) { { "start_date" => '' } }
      let(:booking_form) { BookingForm.new }

      before do
        allow(BookingForm).to receive(:new).with(booking_form_params).and_return(booking_form)
      end

      context 'when the booking form is valid' do
        before do
          allow(booking_form).to receive(:valid?).and_return(true)
          allow(CreatesBooking).to receive(:from_booking_form).with(booking_form)

          post :create, booking_form: booking_form_params
        end

        it { expect(page).to redirect_to(bookings_path) }
      end

      context 'when the booking form is not valid' do
        before do
          allow(booking_form).to receive(:valid?).and_return(false)
          allow(Resource).to receive(:all).and_return(resources)

          post :create, booking_form: booking_form_params
        end

        it { expect(assigns[:resources]).to eq(resources) }
        it { expect(assigns[:booking_form]).to be_a(BookingForm) }
        it { expect(page).to render_template(:new) }
      end
    end
  end

end

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
      before { get :new }

      it { expect(assigns[:booking]).to be_a(Booking) }
      it { expect(page).to render_template(:new) }
    end
  end

end

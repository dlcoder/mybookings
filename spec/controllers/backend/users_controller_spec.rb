require 'spec_helper'

describe Backend::UsersController do

  context 'when the user is not logged in' do
    describe 'on GET to index' do
      before { get :index }

      it { expect(page).to redirect_to(new_user_session_path) }
    end
  end

  context 'when the logged in user is not an admin' do
    describe 'on GET to index' do
      let(:user) { users(:user) }

      before do
        sign_in(user)

        get :index
      end

      it { expect(page).to redirect_to(root_path) }
    end
  end

  context 'when the logged in user is an admin' do
    let(:admin) { users(:admin) }

    before { sign_in(admin) }

    describe 'on GET to index' do
      let(:user_list) { [] }

      before do
        allow(User).to receive(:by_id).and_return(user_list)

        get :index
      end

      it { expect(assigns[:users]).to eq(user_list) }
      it { expect(page).to render_template(:index) }
    end
  end

end

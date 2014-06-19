require 'spec_helper'

describe Admin::ResourcesController do

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
      let(:resources) { [] }

      before do
        allow(Resource).to receive(:by_id).and_return(resources)

        get :index
      end

      it { expect(assigns[:resources]).to eq(resources) }
      it { expect(page).to render_template(:index) }
    end

    describe 'on PUT to switch_availability' do
      let(:resource_id) { "1" }
      let(:resource) { Resource.new }

      before do
        allow(Resource).to receive(:find).with(resource_id).and_return(resource)
        allow(resource).to receive(:switch_availability!)

        put :switch_availability, resource_id: resource_id
      end

      it { expect(page).to redirect_to(admin_resources_path) }
    end
  end

end

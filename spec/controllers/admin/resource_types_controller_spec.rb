require 'spec_helper'

describe Admin::ResourceTypesController do

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
      let(:resource_types) { [] }

      before do
        allow(ResourceType).to receive(:all).and_return(resource_types)

        get :index
      end

      it { expect(assigns[:resource_types]).to eq(resource_types) }
      it { expect(page).to render_template(:index) }
    end

    describe 'on GET to new' do
      before { get :new }

      it { expect(assigns[:resource_type]).to be_a(ResourceType) }
      it { expect(page).to render_template(:new) }
    end

    describe 'on POST to create' do
      let(:resource_type_params) { { 'name' => '' } }
      let(:resource_type) { ResourceType.new(name: '') }

      context 'when the resource params are not valid' do
        before do
          allow(ResourceType).to receive(:new).with(resource_type_params).and_return(resource_type)
          allow(resource_type).to receive(:valid?).and_return(false)

          post :create, resource_type: resource_type_params
        end

        it { expect(page).to render_template(:new) }
      end

      context 'when the resource params are valid' do
        before do
          allow(ResourceType).to receive(:new).with(resource_type_params).and_return(resource_type)
          allow(resource_type).to receive(:valid?).and_return(true)
          allow(resource_type).to receive(:save!)

          post :create, resource_type: resource_type_params
        end

        it { expect(page).to redirect_to(admin_resource_types_path) }
      end
    end
  end

end

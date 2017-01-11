require 'rails_helper'

describe Backend::ResourcesController do

  context 'when the user is not logged in' do
    describe 'on GET to index' do
      before { get :index }

      it { expect(response).to redirect_to(new_user_session_path) }
    end
  end

  context 'when the logged in user is not an admin' do
    describe 'on GET to index' do
      let(:user) { users(:user) }

      before do
        sign_in(user)

        get :index
      end

      it { expect(response).to redirect_to(root_path) }
    end
  end

  context 'when the logged in user is an admin' do
    let(:admin) { users(:admin) }

    before { sign_in(admin) }

    describe 'on GET to index' do
      let(:resources) { [] }
      let(:filtered_resources) { double(by_id: resources) }

      before do
        allow_any_instance_of(ResourcePolicy::Scope).to receive(:resolve).and_return(filtered_resources)

        get :index
      end

      it { expect(assigns[:resources]).to eq(resources) }
      it { expect(response).to render_template(:index) }
    end

    describe 'on PUT to switch_availability' do
      let(:resource_id) { "1" }
      let(:resource) { Resource.new }

      before do
        allow(Resource).to receive(:find).with(resource_id).and_return(resource)
        allow(resource).to receive(:resource_type_managed_by?).with(admin).and_return(true)
        allow(resource).to receive(:switch_availability!)

        put :switch_availability, resource_id: resource_id
      end

      it { expect(response).to redirect_to(backend_resources_path) }
    end

    describe 'on GET to new' do
      let(:managed_resource_types) { [] }

      before do
        allow_any_instance_of(ResourceTypePolicy::Scope).to receive(:resolve).and_return(managed_resource_types)

        get :new
      end

      it { expect(assigns[:resource]).to be_a(Resource) }
      it { expect(assigns[:managed_resource_types]).to eq(managed_resource_types) }
      it { expect(response).to render_template(:new) }
    end

    describe 'on POST to create' do
      let(:resource_params) { { 'name' => '' } }
      let(:resource) { Resource.new(name: '') }
      let(:managed_resource_types) { [] }

      context 'when the resource params are not valid' do
        before do
          allow(Resource).to receive(:new).with(resource_params).and_return(resource)
          allow(resource).to receive(:resource_type_managed_by?).with(admin).and_return(true)
          allow(resource).to receive(:save).and_return(false)
          allow_any_instance_of(ResourceTypePolicy::Scope).to receive(:resolve).and_return(managed_resource_types)

          post :create, resource: resource_params
        end

        it { expect(response).to render_template(:new) }
      end

      context 'when the resource params are valid' do
        before do
          allow(Resource).to receive(:new).with(resource_params).and_return(resource)
          allow(resource).to receive(:resource_type_managed_by?).with(admin).and_return(true)
          allow(resource).to receive(:save).and_return(true)

          post :create, resource: resource_params
        end

        it { expect(response).to redirect_to(backend_resources_path) }
      end
    end
  end

end

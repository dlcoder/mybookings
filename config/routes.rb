Mybookings::Engine.routes.draw do

  devise_for :users,
    class_name: 'Mybookings::User',
    controllers: { omniauth_callbacks: 'mybookings/omniauth_callbacks' },
    module: :devise

  root 'application#index'

  resources :bookings, only: [:create, :index, :show, :destroy] do
    get :new_booking_resource_type_step, on: :collection
    get :new_booking_events_step
  end

  resources :events do
    get :edit_feedback
    put :set_feedback
  end

  namespace :backend do

    resources :resources do
      put :switch_availability
      resources :events do
        get :delete_confirmation
      end
    end

    resources :resource_types

    resources :users

  end

end

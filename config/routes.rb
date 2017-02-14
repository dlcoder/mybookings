Mybookings::Engine.routes.draw do

  devise_for :users,
    class_name: 'Mybookings::User',
    controllers: { sessions: 'mybookings/sessions', omniauth_callbacks: 'mybookings/omniauth_callbacks' },
    module: :devise

  root 'application#index'

  resources :bookings, only: [:index, :edit, :create, :update, :destroy] do
    resources :events do
      get :edit_feedback
      put :set_feedback
    end
  end

  resources :resource_types do
    get 'bookings/new', to: 'bookings#new'
    post 'bookings', to: 'bookings#create'
  end

  resources :resources do
    get :events
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

Mybookings::Engine.routes.draw do

  devise_for :users,
    class_name: 'Mybookings::User',
    controllers: { sessions: 'mybookings/sessions', omniauth_callbacks: 'mybookings/omniauth_callbacks' },
    module: :devise

  root 'application#index'

  resources :bookings, only: [:index, :show, :create, :update, :destroy] do
    resources :events do
      get :edit_feedback
      put :set_feedback
    end
  end

  resources :events, only: [:index]

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

    resources :resource_types do
      get :use_by_resource, on: :member
      get :use_by_hour, on: :member
    end

    resources :users

    resources :statistics, only: [:index]

    get 'statistics/by_resource', to: 'statistics#by_resource'
    get 'statistics/by_hour', to: 'statistics#by_hour'

  end

end

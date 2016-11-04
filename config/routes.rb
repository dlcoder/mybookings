Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  root 'application#index'

  resources :bookings do
    get :edit_feedback
    put :set_feedback
  end

  namespace :backend do

    resources :resources do
      put :switch_availability
      resources :bookings do
        get :delete_confirmation
      end
    end

    resources :resource_types

    resources :users

  end

end

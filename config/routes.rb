Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :users, only: [:index, :new, :create]
  resources :locations

  namespace :api do
    namespace :v1 do
      resources :locations, only: %i[index]
    end
  end
  # Defines the root path route ("/")
  root "locations#index"
end

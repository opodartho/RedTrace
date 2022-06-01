Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  devise_for :users, controllers: { registrations: "users/registrations", passwords: "users/passwords" }

  resources :users, only: [:index, :new, :create]
  namespace :users, as: :user do
    resource :otp, controller: 'otp', only: [] do
      get :new, path: :new, as: :new
      post :send, to: 'otp#fly'
      get :verify_form, path: 'verify/:msisdn'
      post :verify
    end
  end

  resources :locations

  namespace :api do
    namespace :v1 do
      resources :locations, only: %i[index]

      namespace :users, as: :user do
        resource :otp, controller: 'otp', only: [] do
          post :send, to: 'otp#fly'
          post :verify
        end
      end
    end
  end
  # Defines the root path route ("/")
  root "locations#index"
end

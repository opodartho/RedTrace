require_relative '../app/constraints/subdoamin_required.rb'

Rails.application.routes.draw do
  resources :companies

  constraints(SubdomainRequired) do
    use_doorkeeper do
      skip_controllers :authorizations, :applications, :authorized_applications
    end

    devise_for(
      :users,
      controllers: { registrations: 'users/registrations', passwords: 'users/passwords' },
      path_names: { sign_in: :login },
    )

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

    namespace :api, defaults: { format: :json } do
      namespace :v1 do
        resources :locations, only: %i[index]

        resource :otp, controller: 'otp', only: [] do
          post :send, to: 'otp#fly'
          post :verify
        end

        resource :password, controller: 'passwords', only: %i[update]
      end
    end

    get '/',  to: "dashboard#index"
  end

  # Defines the root path route ("/")
  root 'home#index'
end

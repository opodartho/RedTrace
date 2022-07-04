Rails.application.routes.draw do
  constraints(subdomain: 'admin') do
    devise_for(
      :managers,
      controllers: {
        sessions: 'managers/sessions',
      },
      path_names: { sign_in: :login },
    )

    scope module: :admin, as: :admin do
      resources :companies
      resources :locations
      resources :users

      root to: 'companies#index', as: :root
    end
  end

  resources :companies, controller: 'public/companies', only: %i[new create]

  constraints(SubdomainRequired) do
    use_doorkeeper do
      skip_controllers :authorizations, :applications, :authorized_applications
    end

    devise_for(
      :users,
      controllers: { passwords: 'users/passwords' },
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
    resources :locations, only: %i[index]

    namespace :api, defaults: { format: :json } do
      namespace :v1 do
        resources :locations, only: %i[index create]

        resource :otp, controller: 'otp', only: [] do
          post :send, to: 'otp#fly'
          post :verify
        end

        resource :password, controller: 'passwords', only: %i[update]
      end
    end

    root 'dashboard#index'
  end

  # Defines the root path route ("/")
  root 'public/home#index', as: :public_root

  if Rails.env.development?
    resources :sms, controller: 'develop/sms', only: [:index, :destroy]
  end
end

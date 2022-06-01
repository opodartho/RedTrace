module Api
  module V1
    class PasswordsController < ApplicationController
      skip_before_action :doorkeeper_authorize!

      def update
        client_app = Doorkeeper::Application.find_by(uid: params[:client_id])
        return render(json: { error: 'Invalid client ID'}, status: 403) unless client_app


        user = User.reset_password_by_token(user_params)

        if user.errors.empty?
          # create access token for the user, so the user won't need to login again after password reset
          access_token = Doorkeeper::AccessToken.create(
            resource_owner_id: user.id,
            application_id: client_app.id,
            refresh_token: generate_refresh_token,
            expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
            scopes: ''
          )

          # return json containing access token and refresh token
          # so that user won't need to call login API right after password reset
          render(json: {
              access_token: access_token.token,
              token_type: 'Bearer',
              expires_in: access_token.expires_in,
              refresh_token: access_token.refresh_token,
              created_at: access_token.created_at.to_time.to_i
          })
        else
          render json: { errors: user.errors }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.permit(:reset_password_token, :password)
      end

      def generate_refresh_token
        loop do
          # generate a random token string and return it, 
          # unless there is already another token with the same string
          token = Doorkeeper::OAuth::Helpers::UniqueToken.generate
          break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
        end
      end
    end
  end
end

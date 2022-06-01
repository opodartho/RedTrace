module Api
  module V1
    module Users
      class OtpController < ApplicationController
        skip_before_action :doorkeeper_authorize!

        def fly
          @form = ::Users::SendOtpForm.new(send_params)

          if result = @form.submit
            render json: { msisdn: result }
          else
            render json: { errors: @form.errors }
          end
        end

        def verify
          @form = ::Users::VerifyForm.new(verify_params)
          if result = @form.submit
            render json: { reset_password_token: result }
          else
            render json: { errors: @form.errors }
          end
        end

        private

        def send_params
          params.permit(:msisdn)
        end

        def verify_params
          params.permit(:msisdn, :otp)
        end
      end
    end
  end
end

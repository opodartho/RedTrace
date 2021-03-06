module Api
  module V1
    class OtpController < ApplicationController
      skip_before_action :doorkeeper_authorize!

      def fly
        @form = ::Users::SendOtpForm.new(send_params).submit

        if @form.errors.empty?
          render json: { msisdn: @form.msisdn }
        else
          render json: { errors: @form.errors }, status: :unprocessable_entity
        end
      end

      def verify
        @form = ::Users::VerifyForm.new(verify_params).submit

        if @form.errors.empty?
          render json: { reset_password_token: @form.reset_password_token_raw }
        else
          render json: { errors: @form.errors }, status: :unprocessable_entity
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

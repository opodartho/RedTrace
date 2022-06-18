class Users::OtpController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @form = Users::SendOtpForm.new
  end

  def fly
    @form = Users::SendOtpForm.new(send_otp_form_params).submit

    if @form.errors.empty?
      redirect_to verify_form_user_otp_url(@form.msisdn)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def verify_form
    @form = Users::VerifyForm.new(msisdn: params[:msisdn])
  end

  def verify
    @form = Users::VerifyForm.new(verify_form_params).submit

    if @form.errors.empty?
      redirect_to edit_user_password_path(reset_password_token: @form.reset_password_token_raw)
    else
      render :verify_form, status: :unprocessable_entity
    end
  end

  private

  def send_otp_form_params
    params.require(:users_send_otp_form).permit(:msisdn)
  end

  def verify_form_params
    params.require(:users_verify_form).permit(:msisdn, :otp)
  end
end

class Users::OtpController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @resource = User.new
  end

  def fly
    uso = Users::SendOtp.call(msisdn: user_params[:msisdn])

    if uso.errors.present?
      error = uso.errors.first
      @resource = User.new

      render :new, status: error.type
    else
      redirect_to verify_form_user_otp_url(msisdn: user_params[:msisdn])
    end
  end

  def verify_form
    @form = Users::VerifyForm.new(msisdn: params[:msisdn])
  end

  def verify
    @form = Users::VerifyForm.new(verify_form_params)
    if result = @form.submit
      redirect_to edit_user_password_path(reset_password_token: result)
    else
      render :verify_form, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:msisdn)
  end

  def verify_form_params
    params.require(:users_verify_form).permit(:msisdn, :otp)
  end
end

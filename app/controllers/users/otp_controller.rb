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
    @resource = User.find_by(msisdn: params[:msisdn])
  end

  def verify
    @resource = User.find_by(msisdn: user_params[:msisdn])
    if @resource.verify(user_params[:otp], 123123)
      @resource.otp_confirmation_sent_at = nil

      raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
      @resource.reset_password_token = hashed
      @resource.reset_password_sent_at = Time.now.utc
      @resource.save

      redirect_to edit_user_password_path(reset_password_token: raw)
    else
      flash[:notice] = 'Invalid OTP'
      render :verify_form, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:msisdn, :otp)
  end
end

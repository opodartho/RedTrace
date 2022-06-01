class Users::OtpController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @resource = User.new
  end

  def fly
    @resource = User.find_by(msisdn: user_params[:msisdn])

    # find valid registered user
    if @resource.nil?
      @resource = User.new
      flash[:notice] = "Please use registered number"
      return render(:new, status: 404)
    end

    if @resource.otp_confirmation_sent_at.nil? || @resource.otp_confirmation_sent_at + 20.seconds < Time.now.utc
      @resource.otp_confirmation_sent_at= Time.now.utc
      @resource.save
      Rails.logger.debug(@resource.otp(@resource.hop))
      redirect_to verify_form_user_otp_url(msisdn: @resource.msisdn)
    else
      render :new, status: :unprocessable_entity, notice: "Please wait 20 seconds before resend otp."
    end
  end

  def verify_form
    @resource = User.find_by(msisdn: params[:msisdn])
  end

  def verify
    @resource = User.find_by(msisdn: user_params[:msisdn])
    if @resource.verify(user_params[:otp], @resource.hop)
      @resource.otp_confirmation_sent_at = nil

      raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
      @resource.reset_password_token = hashed
      @resource.reset_password_sent_at = Time.now.utc
      @resource.save

      redirect_to edit_user_password_path(reset_password_token: raw)
    else
      render :verify, status: :unprocessable_entity, notice: "Invalid OTP"
    end
  end

  private

  def user_params
    params.require(:user).permit(:msisdn, :otp)
  end
end

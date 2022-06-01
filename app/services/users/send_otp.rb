module Users
  class SendOtp < ApplicationService
    def initialize(params)
      @msisdn = params[:msisdn]
    end

    def call
      set_user
      send_otp unless errors.present?

      user
    end

    private

    attr_reader :msisdn, :user

    def set_user
      @user = User.find_by!(msisdn: msisdn)
    rescue ActiveRecord::RecordNotFound
      errors.add(:base, :not_found, message: 'Please use registered number')
    end

    def send_otp
      if user.otp_confirmation_sent_at.nil? || user.otp_confirmation_sent_at + 20.seconds < Time.now.utc
        user.otp_confirmation_sent_at= Time.now.utc
        user.save

        # Actual send
        Rails.logger.debug(generate_otp)
      else
        errors.add(:base, :unprocessable_entity, message: 'Please wait 20 seconds before resend otp')
      end
    end

    def generate_otp
      ROTP::HOTP.new(user.otp_confirmation_token).at(hop)
    end

    def hop
      user.otp_confirmation_sent_at.to_i - PICCHI_CONST
    end
  end
end

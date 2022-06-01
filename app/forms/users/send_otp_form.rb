module Users
  class SendOtpForm
    include ActiveModel::Model

    attr_accessor :msisdn

    validates :msisdn, presence: true

    def initialize(params = {})
      super(params)
    end

    def submit
      return false if invalid?
      
      # find user
      user = User.find_by(msisdn: msisdn)
      if user.nil?
        errors.add(:base, :not_found, message: 'You have entered a unregistered number')
        return false
      end

      if user.otp_confirmation_sent_at + 20.seconds > Time.now.utc
        errors.add(:base, :unprocessable_entity, message: 'Please wait 20 seconds before resend otp')
        return false
      end

      user.update(otp_confirmation_sent_at: Time.now.utc)

      otp = GenerateOtp.call(
        sent_at: user.otp_confirmation_sent_at,
        token: user.otp_confirmation_token,
      ).result

      Rails.logger.debug(otp)

      msisdn
    end
  end
end

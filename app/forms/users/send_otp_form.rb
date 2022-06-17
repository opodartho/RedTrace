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
      user = User.find_by(msisdn:)
      if user.nil?
        errors.add(:base, :not_found, message: 'You have entered a unregistered number')
        return false
      end

      now = Time.now.utc
      sent_at = user.otp_confirmation_sent_at
      token = user.otp_confirmation_token

      if !sent_at.nil? && (sent_at + 20.seconds).to_i > now.to_i
        errors.add(:base, :unprocessable_entity, message: 'Please wait 20 seconds before resend otp')
        return false
      end

      otp = GenerateOtp.call(
        sent_at: now,
        token:,
      ).result

      user.update(otp_confirmation_sent_at: now)

      SmsClient.new.send_message(to: msisdn, text: I18n.t('otp.sms', otp:))

      msisdn
    end
  end
end

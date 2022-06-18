module Users
  class SendOtpForm
    include ActiveModel::Model

    attr_accessor :msisdn, :user

    validates :msisdn, presence: true

    def initialize(params = {})
      super(params)
    end

    def submit
      return false if invalid?

      # find user
      find_user

      sent_at, token = otp_args

      otp = generate_otp(sent_at, token)

      update_user(sent_at)

      send_sms_with_otp(otp)

      self
    end

    private

    def find_user
      return if errors.present?

      @user = User.find_by(msisdn:)

      errors.add(:base, :not_found, message: 'You have entered a unregistered number') if user.nil?
    end

    def otp_args
      return [nil, nil] if errors.present?

      now = Time.now.utc
      sent_at = user.otp_confirmation_sent_at
      token = user.otp_confirmation_token

      if !sent_at.nil? && (sent_at + 20.seconds).to_i > now.to_i
        errors.add(:base, :unprocessable_entity, message: 'Please wait 20 seconds before resend otp')
      end

      [now, token]
    end

    def generate_otp(sent_at, token)
      return if errors.present?

      GenerateOtp.call(
        sent_at:,
        token:,
      ).result
    end

    def update_user(sent_at)
      return if errors.present?

      user.update(otp_confirmation_sent_at: sent_at)
    end

    def send_sms_with_otp(otp)
      return if errors.present?

      SmsClient.new.send_message(to: msisdn, text: I18n.t('otp.sms', otp:))
    end
  end
end

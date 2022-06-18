module Users
  class VerifyForm
    include ActiveModel::Model

    attr_accessor :msisdn, :otp, :reset_password_token_raw

    validates :msisdn, :otp, presence: true

    def submit
      return false if invalid?

      user = User.find_by(msisdn:)

      verfied = ::VerifyOtp.call(
        sent_at: user&.otp_confirmation_sent_at,
        token: user&.otp_confirmation_token,
        otp:,
      ).result

      errors.add :base, :invalid, message: 'You have entered wrong OTP number' unless verfied

      @reset_password_token_raw = update_user(user) if errors.empty?

      self
    end

    private

    def update_user(user)
      user.otp_confirmation_sent_at = nil

      raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
      user.reset_password_token = hashed
      user.reset_password_sent_at = Time.now.utc
      user.save

      raw
    end
  end
end

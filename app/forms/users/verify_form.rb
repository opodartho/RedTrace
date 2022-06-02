module Users
  class VerifyForm
    include ActiveModel::Model

    attr_accessor :msisdn, :otp

    validates :msisdn, :otp, presence: true

    def submit
      return false if invalid?

      user = User.find_by(msisdn:)

      verfied = ::VerifyOtp.call(
        sent_at: user&.otp_confirmation_sent_at,
        token: user&.otp_confirmation_token,
        otp:,
      ).result

      unless verfied
        errors.add :base, :invalid, message: 'You have entered wrong OTP number'
        return false
      end

      update_user(user)
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

require 'rails_helper'

RSpec.describe VerifyOtp do
  context 'return true' do
    it 'with correct otp' do
      sent_at = Time.now.utc
      token = ROTP::Base32.random
      otp = GenerateOtp.call(sent_at:, token:).result.to_s

      expect(described_class.call(sent_at:, token:, otp:).result).to be_truthy
    end
  end

  context 'return false' do
    it 'with correct otp after 2 minutes' do
      sent_at = Time.now.utc - 2.minutes
      token = ROTP::Base32.random
      otp = GenerateOtp.call(sent_at:, token:).result.to_s

      expect(described_class.call(sent_at:, token:, otp:).result).to be_falsey
    end
  end
end

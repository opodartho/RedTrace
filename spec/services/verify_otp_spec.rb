require 'rails_helper'

RSpec.describe VerifyOtp do
  context 'with correct otp' do
    it 'return true' do
      sent_at = Time.now.utc
      token = ROTP::Base32.random
      otp = GenerateOtp.call(sent_at:, token:).result.to_s

      expect(described_class.call(sent_at:, token:, otp:).result).to be_truthy
    end
  end

  context 'with correct otp after 2 minutes' do
    it 'return false' do
      sent_at = Time.now.utc - 2.minutes
      token = ROTP::Base32.random
      otp = GenerateOtp.call(sent_at:, token:).result.to_s

      expect(described_class.call(sent_at:, token:, otp:).result).to be_falsey
    end
  end
end

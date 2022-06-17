require 'rails_helper'

RSpec.describe Users::SendOtpForm do
  describe '#submit' do
    it 'sends otp' do
      user = create(:user)

      send_otp_form = described_class.new(msisdn: user.msisdn)

      expect { send_otp_form.submit }.to change { SmsClient.adapter.messages.size }.by(1)
    end
  end
end

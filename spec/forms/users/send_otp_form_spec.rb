require 'rails_helper'

RSpec.describe Users::SendOtpForm do
  describe '#submit' do
    context 'sends otp' do
      it 'with valid params' do
        user = create(:user)

        send_otp_form = described_class.new(msisdn: user.msisdn)

        expect { send_otp_form.submit }.to change { SmsClient.adapter.messages.size }.by(1)
      end
    end

    context 'return errors' do
      it 'with unregistered user' do
        send_otp_form = described_class.new(msisdn: '8801833000000')

        expect { send_otp_form.submit }.to change { send_otp_form.errors.size }
      end

      it 'resend otp within 20 seconds' do
        user = create(:user)

        described_class.new(msisdn: user.msisdn).submit

        send_otp_form = described_class.new(msisdn: user.msisdn)

        expect { send_otp_form.submit }.to change { send_otp_form.errors.size }
      end
    end
  end
end

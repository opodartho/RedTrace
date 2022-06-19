require 'rails_helper'

RSpec.describe Users::SendOtpForm do
  describe '#submit' do
    context 'with valid params' do
      it 'sends otp' do
        user = create(:user)

        send_otp_form = described_class.new(msisdn: user.msisdn)

        expect { send_otp_form.submit }.to change { SmsClient.adapter.messages.size }.by(1)
      end
    end

    context 'with unregistered user' do
      it 'return errors' do
        send_otp_form = described_class.new(msisdn: '8801833000000')

        expect { send_otp_form.submit }.to change { send_otp_form.errors.size }
      end
    end

    context 'when resend otp within 20 seconds' do
      it 'return errors' do
        user = create(:user)

        described_class.new(msisdn: user.msisdn).submit

        send_otp_form = described_class.new(msisdn: user.msisdn)

        expect { send_otp_form.submit }.to change { send_otp_form.errors.size }
      end
    end
  end
end

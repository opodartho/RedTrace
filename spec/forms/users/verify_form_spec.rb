require 'rails_helper'

RSpec.describe Users::VerifyForm do
  describe '#submit' do
    context 'successfully set reset_password_token' do
      it 'with valid param' do
        user = create(:user)
        Users::SendOtpForm.new(msisdn: user.msisdn).submit

        otp = SmsAdapters::InMemory.messages.last.text.scan(/\d+/).first

        verify_form = described_class.new(msisdn: user.msisdn, otp:).submit

        expect(verify_form.reset_password_token_raw).to_not be_nil
      end
    end

    context 'return errors' do
      it 'with already used otp' do
        user = create(:user)
        Users::SendOtpForm.new(msisdn: user.msisdn).submit

        otp = SmsAdapters::InMemory.messages.last.text.scan(/\d+/).first

        described_class.new(msisdn: user.msisdn, otp:).submit

        verify_form = described_class.new(msisdn: user.msisdn, otp:)

        expect { verify_form.submit }.to change { verify_form.errors.size }
      end

      it 'with wrong otp' do
        user = create(:user)
        Users::SendOtpForm.new(msisdn: user.msisdn).submit

        verify_form = described_class.new(msisdn: user.msisdn, otp: '123456')

        expect { verify_form.submit }.to change { verify_form.errors.size }
      end
    end
  end
end

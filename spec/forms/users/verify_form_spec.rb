require 'rails_helper'

RSpec.describe Users::VerifyForm do
  describe '#submit' do
    context 'with valid param' do
      it 'successfully set reset_password_token' do
        user = create(:user)
        Users::SendOtpForm.new(msisdn: user.msisdn).submit

        otp = SmsAdapters::InMemory.messages.last.text.scan(/\d+/).first

        verify_form = described_class.new(msisdn: user.msisdn, otp:).submit

        expect(verify_form.reset_password_token_raw).not_to be_nil
      end
    end

    context 'with already used otp' do
      it 'return errors' do
        user = create(:user)
        Users::SendOtpForm.new(msisdn: user.msisdn).submit

        otp = SmsAdapters::InMemory.messages.last.text.scan(/\d+/).first

        described_class.new(msisdn: user.msisdn, otp:).submit

        verify_form = described_class.new(msisdn: user.msisdn, otp:)

        expect { verify_form.submit }.to change { verify_form.errors.size }
      end
    end

    context 'with wrong otp' do
      it 'return errors' do
        user = create(:user)
        Users::SendOtpForm.new(msisdn: user.msisdn).submit

        verify_form = described_class.new(msisdn: user.msisdn, otp: '123456')

        expect { verify_form.submit }.to change { verify_form.errors.size }
      end
    end
  end
end

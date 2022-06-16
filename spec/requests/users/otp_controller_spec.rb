require 'rails_helper'

RSpec.describe Users::OtpController do
  describe '#fly' do
    context 'when msisdn is invalid' do
      it 're-renders the form' do
        company = create(:company)
        params = { users_send_otp_form: { msisdn: 'xyz' } }

        post send_user_otp_url(subdomain: company.subdomain), params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include 'Send OTP'
      end
    end
  end

  describe '#verify' do
    context 'when msisdn or otp is invalid' do
      it 're-renders the form' do
        company = create(:company)
        params = { users_verify_form: { msisdn: '982744200123', otp: '123321' } }

        post verify_user_otp_url(subdomain: company.subdomain), params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include 'Verify'
      end
    end
  end
end

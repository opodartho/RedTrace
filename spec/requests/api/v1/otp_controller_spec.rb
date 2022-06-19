require 'rails_helper'

RSpec.describe Api::V1::OtpController do
  describe '#fly' do
    context 'when msisdn is valid' do
      it 'respond with status success' do
        user = create(:user)
        params = { msisdn: user.msisdn }

        expect {
          post send_api_v1_otp_url(subdomain: user.company.subdomain), params:
        }.to change { SmsClient.adapter.messages.size }.by(1)

        expect(response).to have_http_status(:success)
        expect(response.body).to include user.msisdn
      end
    end

    context 'when msisdn is invalid' do
      it 'response with status unprocessable_entity' do
        company = create(:company)
        params = { msisdn: '8801833000000' }

        expect {
          post send_api_v1_otp_url(subdomain: company.subdomain), params:
        }.not_to change { SmsClient.adapter.messages.size }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#verify' do
    context 'with params is valid' do
      it 'respond with status success' do
        user = create(:user)

        Users::SendOtpForm.new({ msisdn: user.msisdn }).submit

        otp = SmsAdapters::InMemory.messages.last.text.scan(/\d+/).first

        post verify_api_v1_otp_url(subdomain: user.company.subdomain), params: { msisdn: user.msisdn, otp: }

        expect(response).to have_http_status(:success)
      end
    end

    context 'when msisdn or otp is invalid' do
      it 'response with status unprocessable_entity' do
        user = create(:user)
        params = { msisdn: user.msisdn, otp: '000000' }

        post verify_api_v1_otp_url(subdomain: user.company.subdomain), params: params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

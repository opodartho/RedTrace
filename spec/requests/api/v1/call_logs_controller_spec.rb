require 'rails_helper'

RSpec.describe Api::V1::CallLogsController do
  describe 'GET /' do
    context 'with authorized user' do
      it 'return 200:ok' do
        user = create(:user)
        application = create(:application, company_id: user.company_id)
        token = create(:token, application:, company_id: user.company_id, resource_owner_id: user.id)

        call_logs = create_list(:call_log, 3, user:, company: user.company)

        get api_v1_call_logs_url(subdomain: user.company.subdomain),
            headers: { Authorization: "Bearer #{token.token}" }

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['call_logs'].size).to eq(call_logs.size)
      end
    end
  end

  describe 'POST /' do
    context 'with authorized user' do
      it 'return 201:created when params valid' do
        user = create(:user)
        application = create(:application, company_id: user.company_id)
        token = create(:token, application:, company_id: user.company_id, resource_owner_id: user.id)

        expect {
          post api_v1_call_logs_url(subdomain: user.company.subdomain),
               headers: { Authorization: "Bearer #{token.token}" },
               params: { call_log: attributes_for(:call_log) }
        }.to change(CallLog, :count).by(1)

        expect(response).to have_http_status(:created)
      end

      it 'return 201:created when params invalid' do
        user = create(:user)
        application = create(:application, company_id: user.company_id)
        token = create(:token, application:, company_id: user.company_id, resource_owner_id: user.id)

        expect {
          post api_v1_call_logs_url(subdomain: user.company.subdomain),
               headers: { Authorization: "Bearer #{token.token}" },
               params: { call_log: attributes_for(:call_log, msisdn: nil) }
        }.not_to change(CallLog, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

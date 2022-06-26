require 'rails_helper'

RSpec.describe Api::V1::LocationsController do
  describe 'GET /' do
    context 'with authorized user' do
      it 'return 200:ok' do
        user = create(:user)
        application = create(:application, company_id: user.company_id)
        token = create(:token, application:, company_id: user.company_id, resource_owner_id: user.id)

        locations = create_list(:location, 3, user:, company: user.company)

        get api_v1_locations_url(subdomain: user.company.subdomain),
            headers: { Authorization: "Bearer #{token.token}" }

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['locations'].size).to eq(locations.size)
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
          post api_v1_locations_url(subdomain: user.company.subdomain),
              headers: { Authorization: "Bearer #{token.token}" },
              params: { location: attributes_for(:location) }
        }.to change { Location.count }.by(1)

        expect(response).to have_http_status(:created)
      end

      it 'return 201:created when params invalid' do
        user = create(:user)
        application = create(:application, company_id: user.company_id)
        token = create(:token, application:, company_id: user.company_id, resource_owner_id: user.id)

        expect {
          post api_v1_locations_url(subdomain: user.company.subdomain),
              headers: { Authorization: "Bearer #{token.token}" },
              params: { location: attributes_for(:location, latitude: nil) }
        }.to change { Location.count }.by(0)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

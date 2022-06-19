require 'rails_helper'

RSpec.describe Api::V1::LocationsController do
  describe 'GET /' do
    context 'from authorized user' do
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
end

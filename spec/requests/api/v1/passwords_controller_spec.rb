require 'rails_helper'

RSpec.describe Api::V1::PasswordsController do
  describe '#Put /password' do
    context 'with valid params' do
      it 'set password successfully' do
        raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
        user = create(:user, reset_password_token: hashed, reset_password_sent_at: Time.now.utc)
        application = create(:application, company_id: user.company_id)

        params = {
          reset_password_token: raw,
          password: 'secret',
          client_id: application.uid,
          client_secret: application.secret,
        }

        put api_v1_password_url(subdomain: user.company.subdomain), params: params

        expect(response).to have_http_status(:success)
      end
    end
  end
end

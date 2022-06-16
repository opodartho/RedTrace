require 'rails_helper'

RSpec.describe Public::CompaniesController do
  describe '#create' do
    context 'when the company or manager is invalid' do
      it 're-renders the form' do
        invalid_param = {
          company_form: {
            terms_of_service: '0',
            company_attributes: attributes_for(:company),
            user_attributes: attributes_for(:user),
          },
        }
        post companies_url, params: invalid_param

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include 'New company'
      end
    end
  end
end

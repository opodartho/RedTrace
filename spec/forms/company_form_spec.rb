require 'rails_helper'

RSpec.describe CompanyForm do
  describe '#submit' do
    context 'with valid params' do
      it 'create new company and it\'s manager' do
        param = {
          terms_of_service: true,
          company_attributes: attributes_for(:company),
          user_attributes: attributes_for(:user),
        }
        company_form = described_class.new(param)

        expect { company_form.submit }
          .to change(Company, :count).by(1)
          .and change(User, :count).by(1)
          .and change(Doorkeeper::Application, :count).by(1)
      end
    end

    context 'without agree to terms of service' do
      it 'return errors' do
        invalid_param = {
          terms_of_service: false,
          company_attributes: attributes_for(:company),
          user_attributes: attributes_for(:user),
        }
        company_form = described_class.new(invalid_param)

        expect(company_form).to be_invalid
      end
    end

    context 'without valid manager information' do
      it 'return errors' do
        invalid_param = {
          terms_of_service: false,
          company_attributes: attributes_for(:company),
          user_attributes: attributes_for(:user, msisdn: nil),
        }
        company_form = described_class.new(invalid_param)

        expect(company_form).to be_invalid
      end
    end
  end
end

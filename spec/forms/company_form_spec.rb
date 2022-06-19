require 'rails_helper'

RSpec.describe CompanyForm do
  describe '#submit' do
    context 'create new company and it\'s manager' do
      it 'with valid params' do
        param = {
          terms_of_service: true,
          company_attributes: attributes_for(:company),
          user_attributes: attributes_for(:user),
        }
        company_form = described_class.new(param)

        expect { company_form.submit }
          .to change { Company.count }.by(1)
          .and change { User.count }.by(1)
          .and change { Doorkeeper::Application.count }.by(1)
      end
    end

    context 'return errors' do
      it 'without agree to terms of service' do
        invalid_param = {
          terms_of_service: false,
          company_attributes: attributes_for(:company),
          user_attributes: attributes_for(:user),
        }
        company_form = described_class.new(invalid_param)

        expect(company_form).to be_invalid
      end

      it 'without valid manager information' do
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

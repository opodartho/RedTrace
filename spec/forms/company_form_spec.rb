require 'rails_helper'

RSpec.describe CompanyForm do
  describe '#submit' do
    subject {
      {
        terms_of_service: true,
        company_attributes: attributes_for(:company),
        user_attributes: attributes_for(:user),
      }
    }

    context 'create new company and it\'s manager' do
      it 'with valid params' do
        company_form = described_class.new(subject)

        expect { company_form.submit }.to change { Company.count }.by(1).and change { User.count }.by(1)
      end
    end

    context 'return errors' do
      it 'without agree to terms of service' do
        invalid_subject = subject.merge(terms_of_service: false)
        company_form = described_class.new(invalid_subject)

        expect(company_form).to be_invalid
      end

      it 'without valid manager information' do
        invalid_subject = subject.merge(user_attributes: attributes_for(:user, msisdn: nil))
        company_form = described_class.new(invalid_subject)

        expect(company_form).to be_invalid
      end
    end
  end
end

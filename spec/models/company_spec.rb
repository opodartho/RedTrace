require 'rails_helper'

RSpec.describe Company do
  subject(:company) { build(:company) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(company).to be_valid
    end

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:subdomain) }
    it { is_expected.to validate_uniqueness_of(:subdomain) }

    it 'is not valid without valid format' do
      company.subdomain = '@subdomain'
      expect(company).to be_invalid

      company.subdomain = 'subdomain-'
      expect(company).to be_invalid

      company.subdomain = 'sub domain'
      expect(company).to be_invalid

      company.subdomain = 'sub-domain'
      expect(company).to be_valid
    end
  end

  describe 'Associations' do
    it { is_expected.to have_many(:users) }
  end
end

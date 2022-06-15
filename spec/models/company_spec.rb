require 'rails_helper'

RSpec.describe Company, type: :model do
  subject { build(:company) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:subdomain) }
    it { is_expected.to validate_uniqueness_of(:subdomain) }

    it 'is not valid without valid format' do
      subject.subdomain = '@subdomain'
      expect(subject).to be_invalid

      subject.subdomain = 'subdomain-'
      expect(subject).to be_invalid

      subject.subdomain = 'sub domain'
      expect(subject).to be_invalid

      subject.subdomain = 'sub-domain'
      expect(subject).to be_valid
    end
  end

  describe 'Associations' do
    it { is_expected.to have_many(:users) }
  end
end

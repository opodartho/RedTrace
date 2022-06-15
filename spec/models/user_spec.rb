require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:msisdn) }
    it { is_expected.to validate_uniqueness_of(:msisdn).scoped_to(:company_id).case_insensitive }

    it 'is not valid without valid format' do
      subject.msisdn = '01833111111'
      expect(subject).to be_invalid

      subject.msisdn = '0183311111'
      expect(subject).to be_invalid

      subject.msisdn = '+8801833111111'
      expect(subject).to be_invalid

      subject.msisdn = '018331111111'
      expect(subject).to be_invalid

      subject.msisdn = '18331111111'
      expect(subject).to be_invalid

      subject.msisdn = '1833111111'
      expect(subject).to be_invalid

      subject.msisdn = '8801833111111'
      expect(subject).to be_valid
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:company) }
  end
end

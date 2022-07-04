require 'rails_helper'

RSpec.describe CallLog do
  subject(:call_log) { build(:call_log) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(call_log).to be_valid
    end

    it { is_expected.to validate_presence_of(:msisdn) }
    it { is_expected.to validate_presence_of(:call_type) }
    it { is_expected.to validate_presence_of(:duration) }
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:end_time) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:company) }
  end
end

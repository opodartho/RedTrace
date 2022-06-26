require 'rails_helper'

RSpec.describe Location do
  subject(:location) { build(:location) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(location).to be_valid
    end

    it { is_expected.to validate_presence_of(:longitude) }
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:tracked_at) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:company) }
  end
end

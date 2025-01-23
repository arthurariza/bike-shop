require 'rails_helper'

RSpec.describe Customization, type: :model do
  describe 'validations' do
    subject { build(:customization) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:category) }
  end
end

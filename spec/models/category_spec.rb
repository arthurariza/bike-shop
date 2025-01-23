require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    subject { build(:category) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:products).dependent(:destroy) }
    it { is_expected.to have_many(:customizations).dependent(:destroy) }
  end
end

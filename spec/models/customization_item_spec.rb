require 'rails_helper'

RSpec.describe CustomizationItem, type: :model do
  it_behaves_like "purchasable"

  describe 'validations' do
    subject { build(:customization_item) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to have_many(:prohibited_combinations).dependent(:destroy) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:customization) }
    it { is_expected.to have_many(:prohibited_combinations).dependent(:destroy) }
  end
end

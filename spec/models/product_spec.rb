require 'rails_helper'

RSpec.describe Product, type: :model do
  it_behaves_like "purchasable"

  describe 'validations' do
    subject { build(:product) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:customizations).through(:category) }
    it { is_expected.to have_many(:customization_items).through(:customizations) }
  end
end

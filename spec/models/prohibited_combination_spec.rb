require 'rails_helper'

RSpec.describe ProhibitedCombination, type: :model do
  describe 'validations' do
    subject { build(:prohibited_combination) }

    it { is_expected.to validate_presence_of(:customization_item_id) }
    it { is_expected.to validate_presence_of(:prohibited_item_id) }
    it { is_expected.to validate_uniqueness_of(:customization_item_id).scoped_to(:prohibited_item_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:customization_item).class_name('CustomizationItem') }
    it { is_expected.to belong_to(:prohibited_item).class_name('CustomizationItem') }
  end

  describe 'custom validations' do
    it 'does not allow same item for both customization and prohibited item' do
      item = create(:customization_item)
      combination = build(:prohibited_combination, customization_item: item, prohibited_item: item)

      expect(combination).not_to be_valid
      expect(combination.errors[:base]).to include('Cannot prohibit combination of the same item')
    end
  end
end

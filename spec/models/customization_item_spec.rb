require 'rails_helper'

RSpec.describe CustomizationItem, type: :model do
  describe 'validations' do
    subject { build(:customization_item) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:customization) }
  end

  describe '#price=' do
    it 'converts the price to a BigDecimal' do
      item = CustomizationItem.new
      item.price = '19.99'
      expect(item.price).to eq(BigDecimal('19.99'))
    end

    it 'handles integer values correctly' do
      item = CustomizationItem.new
      item.price = '20'
      expect(item.price).to eq(BigDecimal('20'))
    end

    it 'handles float values correctly' do
      item = CustomizationItem.new
      item.price = '20.50'
      expect(item.price).to eq(BigDecimal('20.50'))
    end

    it 'handles invalid values gracefully' do
      item = build(:customization_item, price: 'abcd')
      expect(item.price).to be_nil
      expect(item).to be_invalid
    end
  end
end

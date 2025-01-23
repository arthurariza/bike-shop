require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    subject { build(:product) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:category) }
  end

  describe '#price=' do
    it 'converts the price to a BigDecimal' do
      product = Product.new
      product.price = '19.99'
      expect(product.price).to eq(BigDecimal('19.99'))
    end

    it 'handles integer values correctly' do
      product = Product.new
      product.price = '20'
      expect(product.price).to eq(BigDecimal('20'))
    end

    it 'handles float values correctly' do
      product = Product.new
      product.price = '20.50'
      expect(product.price).to eq(BigDecimal('20.50'))
    end

    it 'handles invalid values gracefully' do
      product = build(:product, price: 'abcd')
      expect(product.price).to be_nil
      expect(product).to be_invalid
    end
  end
end

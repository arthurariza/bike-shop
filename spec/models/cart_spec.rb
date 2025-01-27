require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "associations" do
    it { should have_many(:cart_items).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:total_price) }
    it { should validate_numericality_of(:total_price).is_greater_than_or_equal_to(0) }
    it { should have_many(:cart_items).dependent(:destroy) }
  end

  describe '#total_price=' do
    it 'converts the price to a BigDecimal' do
      item = Cart.new
      item.total_price = '19.99'
      expect(item.total_price).to eq(BigDecimal('19.99'))
    end

    it 'handles integer values correctly' do
      item = Cart.new
      item.total_price = '20'
      expect(item.total_price).to eq(BigDecimal('20'))
    end

    it 'handles float values correctly' do
      item = Cart.new
      item.total_price = '20.50'
      expect(item.total_price).to eq(BigDecimal('20.50'))
    end

    it 'handles invalid values gracefully' do
      item = build(:cart, total_price: 'abcd')
      expect(item.total_price).to be_nil
      expect(item).to be_invalid
    end
  end

  describe '#update_total_price' do
    let(:cart) { create(:cart) }
    let(:product) { create(:product, price: 100) }
    let(:customization) { create(:customization_item, price: 50) }

    it 'updates total_price to 0 for empty cart' do
      cart.update_total_price
      expect(cart.reload.total_price).to eq(0)
    end

    it 'correctly sums multiple products' do
      create_list(:cart_item, 2, cart: cart, purchasable: product)

      cart.update_total_price
      expect(cart.reload.total_price).to eq(200)
    end

    it 'correctly sums multiple customization items' do
      create_list(:cart_item, 2, cart: cart, purchasable: customization)

      cart.update_total_price
      expect(cart.reload.total_price).to eq(100)
    end

    it 'correctly sums mixed products and customization items' do
      create(:cart_item, cart: cart, purchasable: product)
      create(:cart_item, cart: cart, purchasable: customization)

      cart.update_total_price
      expect(cart.reload.total_price).to eq(150)
    end
  end
end

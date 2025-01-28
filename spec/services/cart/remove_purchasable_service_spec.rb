require 'rails_helper'

RSpec.describe Cart::RemovePurchasableService do
  let(:cart) { create(:cart) }
  let(:product) { create(:product, price: 100) }
  let(:other_cart_item) { create(:cart_item, purchasable: product) }

  describe '#call' do
    context 'when removing a cart item' do
      it 'removes the item from cart' do
        cart_item = create(:cart_item, cart: cart, purchasable: product)

        expect {
          described_class.call(cart, cart_item)
        }.to change(cart.cart_items, :count).by(-1)
      end

      it 'updates the cart total price' do
        cart_item = create(:cart_item, cart: cart, purchasable: product)
        cart.update_total_price

        expect {
          described_class.call(cart, cart_item)
        }.to change(cart, :total_price).from(100).to(0.0)
      end

      it 'returns the cart' do
        cart_item = create(:cart_item, cart: cart, purchasable: product)

        result = described_class.call(cart, cart_item)
        expect(result).to eq(cart)
      end
    end

    context 'when cart_item belongs to different cart' do
      it 'does not remove the item' do
        expect {
          described_class.call(cart, other_cart_item)
        }.not_to change(cart.cart_items, :count)
      end

      it 'does not update the cart total price' do
        expect {
          described_class.call(cart, other_cart_item)
        }.not_to change(cart, :total_price)
      end

      it 'returns the cart' do
        result = described_class.call(cart, other_cart_item)
        expect(result).to eq(cart)
      end
    end
  end
end

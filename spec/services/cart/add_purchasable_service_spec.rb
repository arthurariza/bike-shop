require 'rails_helper'

RSpec.describe Cart::AddPurchasableService do
  let(:cart) { create(:cart) }
  let(:product) { create(:product, price: 100, in_stock: true) }
  let(:customization) { create(:customization_item, price: 50, in_stock: true) }

  describe '#call' do
    context 'when adding a product' do
      it 'adds the product to cart and updates total price' do
        result = described_class.call(cart, product)

        expect(result).to eq(cart)
        expect(cart.cart_items.count).to eq(1)
        expect(cart.cart_items.first.purchasable).to eq(product)
        expect(cart.total_price).to eq(100)
      end

      it 'fails when product is out of stock' do
        product.update!(in_stock: false)
        result = described_class.call(cart, product)

        expect(result).to eq(cart)
        expect(cart.cart_items.count).to eq(0)
        expect(cart.errors[:base]).to include("#{product.name} is out of stock")
      end
    end

    context 'when adding a customization item' do
      it 'adds the customization to cart and updates total price' do
        result = described_class.call(cart, customization)

        expect(result).to eq(cart)
        expect(cart.cart_items.count).to eq(1)
        expect(cart.cart_items.first.purchasable).to eq(customization)
        expect(cart.total_price).to eq(50)
      end

      it 'fails when customization is out of stock' do
        customization.update!(in_stock: false)
        result = described_class.call(cart, customization)

        expect(result).to eq(cart)
        expect(cart.cart_items.count).to eq(0)
        expect(cart.errors[:base]).to include("#{customization.name} is out of stock")
      end

      context 'with prohibited combinations' do
        let(:prohibited_customization) { create(:customization_item, price: 30, in_stock: true) }

        before do
          create(:prohibited_combination,
            customization_item: customization,
            prohibited_item: prohibited_customization
          )
        end

        it 'fails when adding prohibited combination' do
          described_class.call(cart, customization)
          result = described_class.call(cart, prohibited_customization)

          expect(result).to eq(cart)
          expect(cart.cart_items.count).to eq(1)
          expect(cart.errors[:base]).to include("#{prohibited_customization.name} cannot be combined with #{customization.name}")
        end

        it 'fails when adding customization prohibited by existing item' do
          described_class.call(cart, prohibited_customization)
          result = described_class.call(cart, customization)

          expect(result).to eq(cart)
          expect(cart.cart_items.count).to eq(1)
          expect(cart.errors[:base]).to include("#{customization.name} cannot be combined with #{prohibited_customization.name}")
        end
      end
    end

    context 'when adding multiple items' do
      it 'correctly updates total price with mixed items' do
        described_class.call(cart, product)
        described_class.call(cart, customization)

        expect(cart.cart_items.count).to eq(2)
        expect(cart.total_price).to eq(150)
      end
    end
  end
end

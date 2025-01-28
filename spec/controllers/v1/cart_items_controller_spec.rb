require 'rails_helper'

RSpec.describe V1::CartItemsController, type: :controller do
  describe 'POST #create' do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }
    let(:valid_params) do
      {
        cart_item: {
          purchasable_type: 'Product',
          purchasable_id: product.id
        }
      }
    end

    before do
      allow(Cart).to receive_message_chain(:includes, :current_cart).and_return(cart)
    end

    context 'when service succeeds' do
      before do
        allow(Cart::AddPurchasableService).to receive(:call).and_return(cart)
        allow(cart).to receive(:errors).and_return([])
      end

      it 'returns success response' do
        post :create, params: valid_params

        expect(response).to have_http_status(:ok)
      end

      it 'calls the service with correct parameters' do
        expect(Cart::AddPurchasableService).to receive(:call).with(cart, product)

        post :create, params: valid_params
      end

      it 'returns serialized cart' do
        post :create, params: valid_params

        expect(response.body).to eq(V1::CartSerializer.new(cart).to_json)
      end
    end

    context 'when service fails' do
      before do
        allow(Cart::AddPurchasableService).to receive(:call).and_return(cart)
        allow(cart).to receive(:errors).and_return(
          double(empty?: false, full_messages: [ 'Item is out of stock' ], to_sentence: 'Item is out of stock')
        )
      end

      it 'returns unprocessable_entity status' do
        post :create, params: valid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        post :create, params: valid_params

        expect(response.parsed_body['errors']).to eq('Item is out of stock')
      end
    end

    context 'with invalid purchasable_type' do
      let(:invalid_params) do
        {
          cart_item: {
            purchasable_type: 'InvalidType',
            purchasable_id: product.id
          }
        }
      end

      it 'raises ArgumentError' do
        expect {
          post :create, params: invalid_params
        }.to raise_error(ArgumentError, "Invalid purchasable_type: InvalidType")
      end
    end

    context 'with non-existent purchasable' do
      let(:non_existent_params) do
        {
          cart_item: {
            purchasable_type: 'Product',
            purchasable_id: 999999
          }
        }
      end

      it 'raises ActiveRecord::RecordNotFound' do
        post :create, params: non_existent_params

        expect(response).to have_http_status(:not_found)
        expect(response.parsed_body['error']).to eq('Not found')
        expect(response.parsed_body['status']).to eq(404)
        expect(response.parsed_body['message']).to match(/Couldn't find Product/)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:cart) { create(:cart) }
    let(:cart_item) { create(:cart_item, cart: cart) }

    before do
      allow(Cart).to receive_message_chain(:includes, :current_cart).and_return(cart)
    end

    context 'when cart item exists' do
      before do
        allow(Cart::RemovePurchasableService).to receive(:call).and_return(cart)
      end

      it 'returns success response' do
        delete :destroy, params: { id: cart_item.id }

        expect(response).to have_http_status(:ok)
      end

      it 'calls the service with correct parameters' do
        expect(Cart::RemovePurchasableService).to receive(:call).with(cart, cart_item)

        delete :destroy, params: { id: cart_item.id }
      end

      it 'returns serialized cart' do
        delete :destroy, params: { id: cart_item.id }

        expect(response.body).to eq(V1::CartSerializer.new(cart).to_json)
      end
    end

    context 'when cart item does not exist' do
      it 'returns not found status' do
        delete :destroy, params: { id: 999999 }

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when cart item belongs to different cart' do
      let(:other_cart) { create(:cart) }
      let(:other_cart_item) { create(:cart_item, cart: other_cart) }

      it 'returns not found status' do
        delete :destroy, params: { id: other_cart_item.id }

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

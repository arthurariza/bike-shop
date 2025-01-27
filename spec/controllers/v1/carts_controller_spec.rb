require 'rails_helper'

RSpec.describe V1::CartsController, type: :controller do
  describe 'GET #show' do
    it 'returns http success' do
      get :show
      expect(response).to have_http_status(:success)
    end

    it 'returns the current cart with its items' do
      cart = create(:cart)
      create_list(:cart_item, 2, cart: cart)
      get :show

      json_response = response.parsed_body

      expect(json_response['id']).to eq(cart.id)
      expect(json_response['total_price']).to eq(cart.total_price.to_s)
      expect(json_response['cart_items'].length).to eq(2)
    end
  end
end

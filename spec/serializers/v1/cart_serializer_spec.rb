require 'rails_helper'

RSpec.describe V1::CartSerializer do
  let(:cart) { create(:cart) }
  let(:serializer) { described_class.new(cart) }
  let(:serialization) { JSON.parse(serializer.to_json) }

  it 'includes the expected attributes' do
    expect(serialization.keys).to match_array(%w[id total_price created_at updated_at cart_items])
  end

  it 'serializes the id' do
    expect(serialization['id']).to eq(cart.id)
  end

  it 'serializes the total price' do
    expect(serialization['total_price']).to eq(cart.total_price.to_s)
  end

  it 'serializes timestamps' do
    expect(serialization['created_at']).to be_present
    expect(serialization['updated_at']).to be_present
  end

  it 'includes cart items' do
    create_list(:cart_item, 2, cart: cart)

    expect(serialization['cart_items'].length).to eq(2)
    expect(serialization['cart_items'].first).to have_key('id')
  end
end

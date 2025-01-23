require 'rails_helper'

RSpec.describe V1::ProductSerializer, type: :serializer do
  let(:category) { create(:category) }
  let(:product) { build(:product, category: category) }
  let(:serializer) { described_class.new(product) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let(:serialized_json) { JSON.parse(serialization.to_json) }

  it 'serializes the id' do
    expect(serialized_json['id']).to eq(product.id)
  end

  it 'serializes the name' do
    expect(serialized_json['name']).to eq(product.name)
  end

  it 'serializes the in_stock' do
    expect(serialized_json['in_stock']).to eq(product.in_stock)
  end

  it 'serializes the price' do
    expect(serialized_json['price']).to eq(product.price.to_s)
  end

  it 'serializes the created_at' do
    expect(serialized_json['created_at']).to eq(product.created_at.as_json)
  end

  it 'serializes the updated_at' do
    expect(serialized_json['updated_at']).to eq(product.updated_at.as_json)
  end
end

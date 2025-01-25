require 'rails_helper'

RSpec.describe V1::Admin::CustomizationItemSerializer, type: :serializer do
  let(:customization_item) { build(:customization_item) }
  let(:serializer) { described_class.new(customization_item) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let(:serialized_json) { JSON.parse(serialization.to_json) }

  it 'includes the expected attributes' do
    expect(serialized_json.keys).to contain_exactly('id', 'name', 'price', 'in_stock', 'created_at', 'updated_at')
  end

  it 'serializes the id correctly' do
    expect(serialized_json['id']).to eq(customization_item.id)
  end

  it 'serializes the name correctly' do
    expect(serialized_json['name']).to eq(customization_item.name)
  end

  it 'serializes the price correctly' do
    expect(serialized_json['price']).to eq(customization_item.price.to_s)
  end

  it 'serializes the in_stock correctly' do
    expect(serialized_json['in_stock']).to eq(customization_item.in_stock)
  end

  it 'serializes the created_at correctly' do
    expect(serialized_json['created_at']).to eq(customization_item.created_at.as_json)
  end

  it 'serializes the updated_at correctly' do
    expect(serialized_json['updated_at']).to eq(customization_item.updated_at.as_json)
  end
end

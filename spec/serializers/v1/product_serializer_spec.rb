require 'rails_helper'

RSpec.describe V1::ProductSerializer, type: :serializer do
  let(:category) { create(:category) }
  let(:product) { build(:product, category: category) }
  let(:customization) { create(:customization, category: category) }
  let(:customization_item) { create(:customization_item, customization: customization) }
  let(:serializer) { described_class.new(product) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let(:serialized_json) { JSON.parse(serialization.to_json) }

  before do
    product.category.customizations << customization
    customization.customization_items << customization_item
  end

  it 'includes the expected attributes' do
    expect(serialized_json.keys).to contain_exactly('id', 'name', 'price', 'created_at', 'updated_at', 'category', 'customizations')
  end

  it 'serializes the id correctly' do
    expect(serialized_json['id']).to eq(product.id)
  end

  it 'serializes the name correctly' do
    expect(serialized_json['name']).to eq(product.name)
  end

  it 'serializes the price correctly' do
    expect(serialized_json['price']).to eq(product.price.to_s)
  end

  it 'serializes the created_at correctly' do
    expect(serialized_json['created_at']).to eq(product.created_at.as_json)
  end

  it 'serializes the updated_at correctly' do
    expect(serialized_json['updated_at']).to eq(product.updated_at.as_json)
  end

  it 'includes the category' do
    expect(serialized_json['category']).to be_present
    expect(serialized_json['category']['id']).to eq(category.id)
    expect(serialized_json['category']['name']).to eq(category.name)
  end

  it 'includes the customizations' do
    expect(serialized_json['customizations']).to be_present
    expect(serialized_json['customizations'].first['id']).to eq(customization.id)
    expect(serialized_json['customizations'].first['items'].first['id']).to eq(customization_item.id)
  end
end

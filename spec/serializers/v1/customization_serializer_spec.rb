require 'rails_helper'

RSpec.describe V1::CustomizationSerializer, type: :serializer do
  let(:category) { create(:category) }
  let(:customization) { build(:customization, category: category) }
  let(:customization_item) { create(:customization_item, customization: customization) }
  let(:serializer) { described_class.new(customization) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let(:serialized_json) { JSON.parse(serialization.to_json) }

  before do
    customization.customization_items << customization_item
  end

  it 'includes the expected attributes' do
    expect(serialized_json.keys).to contain_exactly('id', 'name', 'category_id', 'created_at', 'updated_at', 'items')
  end

  it 'serializes the id correctly' do
    expect(serialized_json['id']).to eq(customization.id)
  end

  it 'serializes the name correctly' do
    expect(serialized_json['name']).to eq(customization.name)
  end

  it 'serializes the category_id correctly' do
    expect(serialized_json['category_id']).to eq(category.id)
  end

  it 'serializes the created_at correctly' do
    expect(serialized_json['created_at']).to eq(customization.created_at.as_json)
  end

  it 'serializes the updated_at correctly' do
    expect(serialized_json['updated_at']).to eq(customization.updated_at.as_json)
  end

  it 'includes the items' do
    expect(serialized_json['items']).to be_present
    expect(serialized_json['items'].first['id']).to eq(customization_item.id)
    expect(serialized_json['items'].first['name']).to eq(customization_item.name)
    expect(serialized_json['items'].first['price']).to eq(customization_item.price.to_s)
    expect(serialized_json['items'].first['in_stock']).to eq(customization_item.in_stock)
  end
end

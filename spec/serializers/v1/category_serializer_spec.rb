require 'rails_helper'

RSpec.describe V1::CategorySerializer, type: :serializer do
  let(:category) { build(:category) }
  let(:serializer) { described_class.new(category) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let(:serialized_json) { JSON.parse(serialization.to_json) }

  it 'includes the expected attributes' do
    expect(serialized_json.keys).to contain_exactly('id', 'name', 'created_at', 'updated_at')
  end

  it 'serializes the id correctly' do
    expect(serialized_json['id']).to eq(category.id)
  end

  it 'serializes the name correctly' do
    expect(serialized_json['name']).to eq(category.name)
  end

  it 'serializes the created_at correctly' do
    expect(serialized_json['created_at']).to eq(category.created_at.as_json)
  end

  it 'serializes the updated_at correctly' do
    expect(serialized_json['updated_at']).to eq(category.updated_at.as_json)
  end
end

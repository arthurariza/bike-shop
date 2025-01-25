require 'rails_helper'

RSpec.describe V1::Admin::ProhibitedCombinationSerializer do
  let(:customization_item) { create(:customization_item) }
  let(:prohibited_item) { create(:customization_item) }
  let(:prohibited_combination) do
    create(:prohibited_combination,
           customization_item: customization_item,
           prohibited_item: prohibited_item)
  end

  let(:serializer) { described_class.new(prohibited_combination) }
  let(:serialization) { JSON.parse(serializer.to_json) }

  it 'includes the expected attributes' do
    expect(serialization.keys).to match_array(%w[
      id
      customization_item_id
      prohibited_item_id
      created_at
      updated_at
      customization_item
      prohibited_item
    ])
  end

  it 'serializes the basic attributes correctly' do
    expect(serialization['id']).to eq(prohibited_combination.id)
    expect(serialization['customization_item_id']).to eq(prohibited_combination.customization_item_id)
    expect(serialization['prohibited_item_id']).to eq(prohibited_combination.prohibited_item_id)
    expect(serialization['created_at']).to be_present
    expect(serialization['updated_at']).to be_present
  end

  it 'serializes the associated customization_item' do
    expect(serialization['customization_item']).to be_present
    expect(serialization['customization_item']['id']).to eq(customization_item.id)
  end

  it 'serializes the associated prohibited_item' do
    expect(serialization['prohibited_item']).to be_present
    expect(serialization['prohibited_item']['id']).to eq(prohibited_item.id)
  end
end

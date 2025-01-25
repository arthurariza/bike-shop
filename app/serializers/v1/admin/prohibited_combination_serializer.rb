class V1::Admin::ProhibitedCombinationSerializer < ActiveModel::Serializer
  attributes :id, :customization_item_id, :prohibited_item_id, :created_at, :updated_at

  belongs_to :customization_item, serializer: V1::Admin::CustomizationItemSerializer
  belongs_to :prohibited_item, serializer: V1::Admin::CustomizationItemSerializer
end

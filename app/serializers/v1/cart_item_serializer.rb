class V1::CartItemSerializer < ActiveModel::Serializer
  attributes :id, :purchasable, :created_at, :updated_at
end

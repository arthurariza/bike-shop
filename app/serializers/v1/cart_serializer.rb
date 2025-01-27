class V1::CartSerializer < ActiveModel::Serializer
  attributes :id, :total_price, :created_at, :updated_at

  has_many :cart_items, serializer: V1::CartItemSerializer
end

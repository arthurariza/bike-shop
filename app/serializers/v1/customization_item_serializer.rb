class V1::CustomizationItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :in_stock, :created_at, :updated_at
end

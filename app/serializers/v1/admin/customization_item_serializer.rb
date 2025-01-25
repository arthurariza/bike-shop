class V1::Admin::CustomizationItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :in_stock, :created_at, :updated_at
end

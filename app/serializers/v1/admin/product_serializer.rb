class V1::Admin::ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :in_stock, :price, :created_at, :updated_at
end

class V1::ProductsSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :created_at, :updated_at, :category

  belongs_to :category, serializer: V1::CategorySerializer
end

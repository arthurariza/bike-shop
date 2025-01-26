class V1::ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :created_at, :updated_at, :category, :customizations

  belongs_to :category, serializer: V1::CategorySerializer
  has_many :customizations, serializer: V1::CustomizationSerializer
end

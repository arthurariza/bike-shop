class V1::Admin::CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at
end

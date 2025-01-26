class V1::CustomizationSerializer < ActiveModel::Serializer
  attributes :id, :name, :category_id, :created_at, :updated_at, :items

  def items
    object.customization_items.map do |item|
      V1::CustomizationItemSerializer.new(item).attributes
    end
  end
end

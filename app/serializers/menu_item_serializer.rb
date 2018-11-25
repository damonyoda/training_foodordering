class MenuItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :unit_price, :category_id, :position
  
  belongs_to :category
end

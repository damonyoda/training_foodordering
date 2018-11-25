# == Schema Information
#
# Table name: ordered_items
#
#  id           :bigint(8)        not null, primary key
#  order_id     :bigint(8)
#  menu_item_id :bigint(8)
#  quantity     :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class OrderedItem < ApplicationRecord
  belongs_to :order
  belongs_to :menu_item
  
  validates :order, presence: true
  
  
  def manage_quantity(increasing_quantity, add_or_minus_quantity, input_quantity=0)

    if add_or_minus_quantity
        if increasing_quantity
          self.quantity += 1
          save
        else 
          if quantity > 1
            self.quantity -= 1
            save
          else 
            destroy
          end
        end
    else 
        if input_quantity.to_i > 0
          self.quantity = input_quantity
          save
        else
          destroy
        end
    end
  end 



end

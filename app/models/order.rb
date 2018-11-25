# == Schema Information
#
# Table name: orders
#
#  id            :bigint(8)        not null, primary key
#  ordering_date :date
#  user_id       :bigint(8)
#  remark        :text(65535)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Order < ApplicationRecord
  has_many :ordered_items
  belongs_to :user
  validates :user, presence: true
  
  def total_amount
    total = 0.0
    ordered_items.each do |ordered_item|
      total += ordered_item.quantity * ordered_item.menu_item.unit_price
    end
    total
  end
  
  
  
end

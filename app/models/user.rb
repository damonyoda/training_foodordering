# == Schema Information
#
# Table name: users
#
#  id             :bigint(8)        not null, primary key
#  display_name   :string(255)      not null
#  email          :string(255)      not null
#  contact_number :string(255)      not null
#  password       :string(255)      not null
#  is_admin       :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class User < ApplicationRecord
    
    has_many :orders
    validates :display_name, presence: true, length: { minimum: 4 }
    validates :email, presence: true, uniqueness: true
    validates :contact_number, presence: true
    validates :password, presence: true, length: { in: 6..20 }
    
end

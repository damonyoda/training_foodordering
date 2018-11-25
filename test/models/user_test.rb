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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

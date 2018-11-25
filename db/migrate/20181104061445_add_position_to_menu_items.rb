class AddPositionToMenuItems < ActiveRecord::Migration[5.2]
  def change
    add_column :menu_items, :position, :integer, default: 0
  end
end

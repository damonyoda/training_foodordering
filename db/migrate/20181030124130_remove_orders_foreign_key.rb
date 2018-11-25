class RemoveOrdersForeignKey < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key "ordered_items", "menu_items"
    remove_foreign_key "ordered_items", "orders"
  end
end

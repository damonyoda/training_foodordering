class CreateMenuItems < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_items do |t|
      t.string :name, null: false, unique: true
      t.text :description
      t.decimal :unit_price, precision: 8, scale: 2, default: 0.0
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end

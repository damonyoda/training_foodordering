class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.date :ordering_date
      t.references :user, foreign_key: true
      t.text :remark

      t.timestamps
    end
  end
end

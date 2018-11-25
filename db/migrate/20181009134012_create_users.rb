class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :display_name, null: false
      t.string :email, null: false, unique: true
      t.string :contact_number, null: false, unique:true
      t.string :password, null: false
      t.boolean :is_admin, default: false 

      t.timestamps
    end
  end
end

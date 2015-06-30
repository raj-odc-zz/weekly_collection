class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :location
      t.string :mobile_number
      t.string :phone_number
      t.string :email_id
      t.text :address

      t.timestamps
    end
    add_index :customers, :name
    add_index :customers, :location
    add_index :customers, :mobile_number
  end
end

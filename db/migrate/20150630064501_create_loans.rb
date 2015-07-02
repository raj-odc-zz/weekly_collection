class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.references :customer, index: true
      t.integer :order_no
      t.integer :loan_type
      t.integer :vasool_day
      t.date :given_date
      t.float :loan_amount, default: 0
      t.float :given_amount, default: 0
      t.float :installment_amount, default: 0
      t.integer :installments, default: 0
      t.float :paid_amount, default: 0
      t.float :balance_amount, default: 0
      t.boolean :active_status, default: true

      t.timestamps
    end
    add_index :loans, :order_no, unique: true
    add_index :loans, :loan_type
    add_index :loans, :vasool_day
    add_index :loans, :active_status
  end
end

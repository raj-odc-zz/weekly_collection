class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.float :opening_balance, default: 0
      t.float :collection_amount, default: 0
      t.float :other_income, default: 0
      t.float :new_loan, default: 0
      t.float :other_expenses, default: 0
      t.float :closing_balance, default: 0
      t.date :entry_date

      t.timestamps
    end
    add_index :transactions, :entry_date
  end
end

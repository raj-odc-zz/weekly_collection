class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.references :expense_type, index: true
      t.float :amount
      t.date :spend_date
      t.references :user, index: true
      t.timestamps
    end
  end
end

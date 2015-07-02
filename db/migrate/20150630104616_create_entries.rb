class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :entry_type, index: true
      t.references :user, index: true
      t.float :amount, default: 0
      t.date :entry_date

      t.timestamps
    end
  end
end

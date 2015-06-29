class CreateEntryTypes < ActiveRecord::Migration
  def change
    create_table :entry_types do |t|
      t.string :name
      t.boolean :income

      t.timestamps
    end
  end
end

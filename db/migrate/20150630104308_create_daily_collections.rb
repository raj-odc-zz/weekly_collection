class CreateDailyCollections < ActiveRecord::Migration
  def change
    create_table :daily_collections do |t|
      t.references :loan, index: true
      t.float :amount, default: 0
      t.date :collection_date
      t.references :user, index: true
      t.timestamps
    end
  end
end

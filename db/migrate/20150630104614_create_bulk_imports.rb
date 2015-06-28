class CreateBulkImports < ActiveRecord::Migration
  def change
    create_table :bulk_imports do |t|
      t.boolean :status
      t.date :collection_date
      t.references :user, index: true
      t.timestamps
    end
  end
end

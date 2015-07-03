class AddColumnCustomer < ActiveRecord::Migration
  def change
      add_column :customers, :active_status, :boolean, :default => true
  end
end

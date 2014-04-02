class AddIsEnabledToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_enabled, :boolean, :default => false

  end
end

class AddExternalResourceToUser < ActiveRecord::Migration
  def change
    add_column :users, :external_resource, :string
  end
end

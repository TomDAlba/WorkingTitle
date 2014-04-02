class AddExternalLinkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :external_link, :string

  end
end

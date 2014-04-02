class AddExternalDomainToUsers < ActiveRecord::Migration
  def change
    add_column :users, :external_domain, :string

  end
end

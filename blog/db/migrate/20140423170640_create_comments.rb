class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :text
      t.integer :project_id
      t.text :username

      t.timestamps
    end
  end
end

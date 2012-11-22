class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.integer :user_id
      t.boolean :is_public, :default => false
      t.integer :likes, :default => 0

      t.timestamps
    end
  end
end

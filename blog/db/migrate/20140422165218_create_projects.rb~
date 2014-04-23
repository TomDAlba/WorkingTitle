class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :prompt_id
      t.string :title
      t.string :body
      t.integer :user_id

      t.timestamps
    end
  end
end

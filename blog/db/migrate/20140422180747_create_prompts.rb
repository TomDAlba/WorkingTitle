class CreatePrompts < ActiveRecord::Migration
  def change
    create_table :prompts do |t|
      t.text :data
      t.text :title
      t.timestamps
    end
  end
end

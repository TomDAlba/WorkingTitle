class CreatePicturesPosts < ActiveRecord::Migration
  def change
    create_table :pictures_posts do |t|
      t.integer :post_id
      t.string :image

      t.timestamps
    end
  end
end

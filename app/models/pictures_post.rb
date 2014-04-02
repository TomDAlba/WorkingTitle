class PicturesPost < ActiveRecord::Base
  attr_accessible :post_id, :name, :image
  validates_presence_of :image
  mount_uploader :image, PictureUploader
end

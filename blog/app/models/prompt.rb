class Prompt < ActiveRecord::Base
  has_many :projects
  belongs_to :user

  attr_accessible :title, :data

end

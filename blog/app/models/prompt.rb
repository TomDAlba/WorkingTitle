class Prompt < ActiveRecord::Base
  has_many :projects

  attr_accessible :title, :data

end

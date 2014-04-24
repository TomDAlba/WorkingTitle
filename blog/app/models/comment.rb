class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  attr_accessible :text, :project_id, :user_id, :username

end

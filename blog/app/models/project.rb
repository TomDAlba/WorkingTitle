class Project < ActiveRecord::Base
  belongs_to :user
  has_one :prompt
  has_many :comments

  attr_accessible :title, :body, :prompt_id
  protected
  
  
end

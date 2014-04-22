class Project < ActiveRecord::Base
  belongs_to :user
  has_one :prompt

  attr_accessible :title, :body, :prompt_id
  protected
  
  
end

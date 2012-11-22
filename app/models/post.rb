class Post < ActiveRecord::Base
  paginates_per 10
  validates :title, :presence => true, :length => {:minimum => 1, :maximum => 100}
  #validates :body, :presence => true
  validates :user_id, :presence => true
  has_many :posts_images

  belongs_to :user

  scope :visible, lambda{|user|
    if user.role?(:admin)
      where(:is_public => true).order("updated_at desc")
    else
      where(:is_public => true, :user_id => user.id).order("updated_at desc")
    end
  }

  scope :draft, lambda{|user|
    if user.role?(:admin)
      where(:is_public => false).order("updated_at desc")
    else
      where(:is_public => false, :user_id => user.id).order("updated_at desc")
    end
  }

  def get_rc
    self.body.blank? ? "" : RedCloth.new(self.body).to_html
  end

  def world_count
    self.body.blank? ? 0 : self.body.split(" ").size
  end

  def reading_time
    rt = world_count/2.80/60
    return rt==0 ? 1 : rt.to_i
  end

  def add_like
    update_attribute(:likes, likes.to_i+1)
  end

  def self.likes_count
    t = 0
    Post.all.each{|p| t+=p.likes.to_i}
    return t
  end

  def self.words_count
    t = 0
    Post.all.each{|p| t+=p.world_count}
    return t
  end

  def self.reading_times
    t = 0
    Post.all.each{|p| t+=p.reading_time}
    return t
  end

  def to_param
    "#{id}-#{self.title.parameterize}"
  end

end

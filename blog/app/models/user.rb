class User < ActiveRecord::Base
  has_merit

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name,
                   :last_name, :subdomain, :username, :skill, :bio, :color, :analytics,
                    :typekit, :login, :logo, :is_enabled, :external_link, :external_domain,
                    :twitter, :external_resource, :num_projects, :num_prompts

  #Make sure data entered in corrently
  validates :username, :presence => true, :length => {:minimum => 4, :maximum => 20}, :uniqueness => true
  validate :username_not_only_number, :allow_blank => true
  validates_format_of :username, :with => /\A[A-Za-z0-9_.&]*\z/, :message => I18n.t(:only_letters_digit_dot), :allow_blank => true
  validates :subdomain, :presence => true, :length => {:minimum => 4, :maximum => 15}, :uniqueness => true
  validates_format_of :subdomain, :with => /\A[A-Za-z0-9]+\z/
  has_and_belongs_to_many :roles
  has_one :profile
  has_many :projects
  has_many :comments

  scope :author, joins(:roles).where('roles.alias = ?', "User")
  scope :author_enabled, lambda{|limit|
    joins(:roles).where('roles.alias = ?', "User").where(:is_enabled => true).order("created_at desc").limit(limit)
  }
  scope :author_disabled, lambda{|limit|
    joins(:roles).where('roles.alias = ?', "User").where(:is_enabled => false).order("created_at desc").limit(limit)
  }

  def username_not_only_number
    reg=/\A[0-9]+\z/
    if reg.match(username)
      errors.add(:username, I18n.t(:can_not_only_numbers))
    end
  end
  
  # Generate roles for user
  def role?(role)
    !!self.roles.select('name').find_by_name(role.to_s.camelize)
  end
  

 #Gereate login conditions
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def get_color
    color.blank? ? "#EEEEEE" : color
  end
end

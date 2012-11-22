class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    if user.role? :admin
      can :manage, :all
      can :manage, :member
    elsif user.role? :user
      can :manage, Post, :user_id => user.id

      can :edit, :member
      can :edit, User, :id => user.id

      can :update, :member
      can :update, User, :id => user.id

    else
      can :read, Post
      can :read, :member
    end

  end

end

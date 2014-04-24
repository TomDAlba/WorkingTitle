class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  def show
    @projects = Project.find(:all, :conditions => {:user_id => session[:user_id]})
  end

  def show_by_user
    @profile_user = User.find(:comment_user)
    @projects = Project.find(:all, :conditions => {:user_id => @profile_user})
  end
end

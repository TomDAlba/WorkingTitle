class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  def show #local variables for displaying profile
    @projects = Project.find(:all, :conditions => {:user_id => session[:user_id]})
  end

  def show_by_user #show profile of specific user
    @profile_user = User.find(:comment_user)
    @projects = Project.find(:all, :conditions => {:user_id => @profile_user})
  end
end

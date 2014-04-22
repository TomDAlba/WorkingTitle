class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  def show
    @projects = Project.find(:all, :conditions => {:user_id => session[:user_id]})
  end
end

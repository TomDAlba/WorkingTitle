class JoinController < ApplicationController
  def index
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    #@user.roles << Role.find_by_alias(:user)
    @user.is_enabled = false
    @user.add_badge(1)
    @user.subdomain = @user.username
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
      else
        logger.info "\n ---> #{@user.errors.full_messages}\n"
        format.html { render action: "index" }
      end
    end
    
  end
end

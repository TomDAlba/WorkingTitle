class MembersController < ApplicationController
  authorize_resource :class => false, :except => [:index,:show]


  def index #set variables for users index

    @post = Post.all

    respond_to do |format|
      if current_user.present?
        @users = User.author_enabled(1000)
        if current_user.role?(:admin)
          format.html
        else
          format.html{ render :template => "members/fe/index", :layout => "application"}
        end
      else
        @users = User.author_enabled(1000)
        format.html{ render :template => "members/fe/index"}
      end
    end
  end

  def show #display user
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.rss
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new #new user generation
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def edit #edit user params
    @user = User.find(params[:id])
    authorize! :edit, @user
    render (current_user.role?(:admin) ? :edit : :setting)
  end

  def create #generate a new user in db
    @user = User.new(params[:user])
    @user.roles << Role.find_by_alias(:user)
    @user.subdomain = @user.username

    respond_to do |format|
      if @user.save
        format.html { redirect_to members_path, notice: 'User was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update #update in db
    @user = User.find(params[:id])
    params_user
    authorize! :update, @user
    if @user.update_without_password(params_user)
      @user.update_attribute(:subdomain, @user.username)
      path_to_redirect = current_user.role?(:admin) ? members_path : posts_path
      redirect_to path_to_redirect, notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy #remove user from db
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      if params[:from].present?
        if params[:from]=="dashboard"
          format.html { redirect_to dashboard_index_path }
        end
      else
        format.html { redirect_to members_url }
      end
    end
  end

  def params_user #generate params
    _params = [:skill, :email, :password,
        :password_confirmation,
        :color, :logo, :external_link,
        :twitter, :bio, :analytics, :external_domain, :external_resource]
    params[:user].delete_if{|k,v| _params.include?(k)} unless current_user.role? :admin
    params[:user]
  end

end

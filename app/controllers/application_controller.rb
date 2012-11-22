class ApplicationController < ActionController::Base
  protect_from_forgery
  include UrlHelper
  before_filter :check_domain
  layout :choose_layout

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
    if resource.role?(:admin)
      dashboard_index_path
    elsif resource.role?(:user)
      posts_path
    else
      root_path
    end
  end

  def check_domain

    unless request.host.include?("simvla.com")

      if controller_name.to_s.include?("members")
        # MEMBER
        @user = User.find(params[:id])
        @posts = Post.visible(@user)
        respond_to do |format|
          format.rss
        end
      elsif params[:action].to_s.include?("add_like")
        # do nothing
        logger.info "\n do nothing \n"
      else
        # POSTS
        users = User.where(:external_domain => request.host.gsub("www.","").to_s)
        logger.info "\n users #{users.count}\n"
        if users.present?
          @user = users.first
          if params[:id].present?
            @post = Post.find(params[:id])
          else
            @posts = Post.visible(@user).page params[:page]
          end
          respond_to do |format|
            if params[:id].present?
              format.html{ render :template => "posts/fe/show_post", layout: 'blog'}
            else
              format.html{ render :template => "posts/fe/show", layout: 'blog'}
            end
          end
        end
      end
    end
  end

  private
    def choose_layout
      logger.info "\n HOST #{request.host}\n"
      if current_user.present?
        if current_user.role?(:admin)
          'backend_admin'
        else
          'backend'
        end
      else
        'application'
      end
    end

end

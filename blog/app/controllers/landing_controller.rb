class LandingController < ApplicationController
  def index #generate homepage

    respond_to do |format|
      if current_user.present?
        @users = User.author_enabled(1000)
        if current_user.role?(:admin)
          format.html{ redirect_to members_path }
        else
          format.html{ render :template => "members/fe/index", :layout => "application"}
        end
      else
        @users = User.author_enabled(1000)
        format.html{ render :template => "members/fe/index", :layout => "application"}
      end
    end
    
  end
end

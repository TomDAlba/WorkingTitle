class ApplicationController < ActionController::Base
  protect_from_forgery
  include UrlHelper
  #before_filter :check_domain
  layout :choose_layout

  
  private
  #Determine layout to render
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

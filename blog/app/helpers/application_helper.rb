module ApplicationHelper

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def present_link(user)
     options = {:subdomain => user.subdomain}
     options = options.merge(:port=>80) if Rails.env.production?
     user.external_link.present? ? user.external_link :  root_url(options)
   end

   def url_no_protocol(url)
     url.gsub(/http:\/\/|www\.|@/,'') if url
   end

end

xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    if @posts.first.user.role?(:admin)
      xml.title "Simvla Network"
      xml.description "All posts within the Network"
    else
      xml.title @posts.first.user.full_name
      xml.description @posts.first.user.bio
    end

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description raw(post.get_rc)
        xml.pubDate post.created_at.to_s(:rfc822)
        
        if request.host.include?("simvla.com") || post.user.external_domain.blank?
          xml.link root_url(:subdomain => post.user.subdomain, :port => nil).chop+url_for(post)
          xml.guid root_url(:subdomain => post.user.subdomain, :port => nil).chop+url_for(post)
        else
          xml.link "http://"+post.user.external_domain+url_for(post)
          xml.guid "http://"+post.user.external_domain+url_for(post)
        end
      end
    end
  end
end
namespace :seed do
  
  task :create_admin => :environment do
		u = User.create(:email => "admin@simvla.com", 
		            :password => "eF3D2gg_h43lp", 
		            :password_confirmation => "eF3D2gg_h43lp", 
		            :last_name => "admin", 
		            :first_name => "admin", 
		            :username => "admin",
		            :subdomain => "admin",
		            :skill => "admin",
		            :bio => "admin",
		            :color => "000000",
		            )
		u.roles << Role.find_by_alias(:admin)
	end

	task :create_roles => :environment do
	  Role.create!(:name => "Admin", :alias => "admin")
	  Role.create!(:name => "User", :alias => "user")
  end
  
  task :create_data => :environment do
    
    User.includes(:roles).where(:roles => {:alias => "user"}).each{|u|u.delete}
    Post.delete_all
    
    (1..10).each do |user|
      psw = "simvla1"
      username = Forgery(:internet).user_name
  		u = User.create(:email => Forgery(:internet).email_address, 
  		            :password => psw, 
  		            :password_confirmation => psw, 
  		            :last_name => Forgery(:name).last_name, 
  		            :first_name => Forgery(:name).first_name, 
  		            :username => username,
  		            :subdomain => username ,
  		            :skill => Forgery(:name).job_title,
  		            :bio => Forgery(:lorem_ipsum).words,
  		            :color => Forgery(:basic).hex_color
  		            )
  		puts u.errors.full_messages
  		u.roles << Role.find_by_alias(:user)
  		
  		(1..20).each do |post|
  		  p = Post.create(:title => Forgery(:lorem_ipsum).words,
  		              :body => Forgery(:lorem_ipsum).sentences(50),
  		              :user_id => u.id,
  		              :is_public => Forgery(:basic).boolean
  		              )
  		  puts p.errors.full_messages
        
		  end
  		
      
    end
  end
	
	task :clear => :environment do
	 Post.delete_all
	end
	
	
end
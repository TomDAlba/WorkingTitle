require "bundler/capistrano"

default_run_options[:pty] = true

set :application, "simvla"
set :repository,  ""
set :scm, :git

set :user, "deploy"


set :branch, "master"

default_run_options[:pty] = true

set :deploy_to, "/home/#{user}/apps/#{application}"
server "176.58.112.144", :app, :web, :db, :primary => true
# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts
set :rails_env, :production

ssh_options[:forward_agent] = true

#after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  task :setup_config, roles: :app do
     sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
     sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
     run "mkdir -p #{shared_path}/config"
     put File.read("config/database.yml"), "#{shared_path}/config/database.yml"
     puts "Now edit the config files in #{shared_path}."
 end

  %w[start stop restart].each do |command|
     desc "#{command} unicorn server"
     task command, roles: :app, except: {no_release: true} do
       run "/etc/init.d/unicorn_#{application} #{command}"
     end
  end

  task :start do ; end
  task :stop do ; end
  task :symlink do
           run           "rm #{current_path}/config/database.yml;echo 'delete db configuration file'"
           run           "ln -s #{shared_path}/config/database.yml #{current_path}/config/database.yml"
           #             echo #{shared_path}/config/database.yml && echo #{release_path}/config/database.yml;
           #             ln -s #{release_path} #{current_path};
           #             echo 'new current link';
           #             chown apache:apache -R #{release_path};
           #             service httpd restart;echo 'restart server'"
    end

  task :migrate  do
    run "cd #{current_path}; bundle exec rake db:migrate RAILS_ENV=production"
  end

  task :bundle  do
     run "cd #{current_path}; bundle exec bundle install"
  end


end





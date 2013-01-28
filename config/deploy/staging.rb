set :user,              "vagrant"
set :group,             "vagrant"
set :use_sudo,          false
set :deploy_to,         "/home/vagrant/#{application}"
set :unicorn_env,       "staging"
set :server_name,       "example.com"

server "192.168.0.41", :app, :web, :db, :primary => true

# Since we're using pty, load the path ourselves
set :default_environment, {
  "PATH" => "/home/vagrant/.rbenv/shims:/home/vagrant/.rbenv/bin:$PATH"
}
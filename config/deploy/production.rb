set :user,              "ubuntu"
set :group,             "ubuntu"
set :use_sudo,          false
set :deploy_to,         "/home/ubuntu/#{application}"
set :unicorn_env,       "production"
set :server_name,       "example.com"

server "address", :app, :web, :db, :primary => true

# Since we're using pty, load the path ourselves
set :default_environment, {
  "PATH" => "/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:$PATH"
}
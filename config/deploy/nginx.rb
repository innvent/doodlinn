Capistrano::Configuration.instance.load do
  namespace :nginx do

    desc "Setup application in nginx"
    task :setup, :roles => :web do
      config_file = "config/deploy/templates/nginx_virtual_host_conf.erb"
      config = ERB.new(File.read(config_file)).result(binding)
      put config, "/tmp/#{application}"
      run "#{sudo} mv /tmp/#{application} /etc/nginx/sites-available/#{application}"
      run "#{sudo} ln -fs /etc/nginx/sites-available/#{application} /etc/nginx/sites-enabled/#{application}"
      run "mkdir -p #{shared_path}/sockets"
    end

    desc "Reload nginx configuration"
    task :reload, :roles => :web do
      run "#{sudo} /etc/init.d/nginx reload"
    end

  end
end

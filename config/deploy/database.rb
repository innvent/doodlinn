Capistrano::Configuration.instance.load do
  namespace :deploy do
    namespace :db do

      desc <<-DESC
        Creates the databse.yml file in shared path and creates the database
      DESC
      task :setup, :except => { :no_release => true } do
        default_template = <<-EOF
production:
  adapter: postgresql
  encoding: unicode
  database: #{application}_production
  pool: 5
  timeout: 5000
  template: template0
        EOF

        config = ERB.new(default_template)

        run "mkdir -p #{shared_path}/config"
        put config.result(binding), "#{shared_path}/config/database.yml"
      end

      desc <<-DESC
        [internal] Updates the symlink for database.yml file to the just deployed release.
      DESC
      task :symlink, :except => { :no_release => true } do
        run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
      end

      desc <<-DESC
        Creates the database itself
      DESC
      task :create, :except => { :no_release => true } do
        run "sudo -u postgres createuser --superuser $USER"
        run "createdb #{application}_production --template=template0 --encoding=unicode"
      end

    end
  end
end
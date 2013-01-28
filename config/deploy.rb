set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'
require 'bundler/capistrano'
require 'capistrano-unicorn'
require File.expand_path('../deploy/database', __FILE__)
require File.expand_path('../deploy/nginx', __FILE__)

set :application,           "doodlinn"
set :repository,            "git@github.com:innvent/doodlinn.git"
set :ssh_options,           { :forward_agent => true }
set :scm,                   :git
set :branch,                "cap"
set :scm_verbose,           true
set :deploy_via,            :remote_cache
set :rails_env,             "production"
default_run_options[:pty]   = true
ssh_options[:forward_agent] = true

logger.level = Capistrano::Logger::INFO  # Log levels: IMPORTANT, INFO, DEBUG, TRACE, MAX_LEVEL)

after "deploy:restart",         "unicorn:reload"    # app IS NOT preloaded
after "deploy:restart",         "unicorn:restart"   # app preloaded
before "deploy:restart",        "deploy:db:symlink"
after "deploy:setup",           "deploy:db:setup"
after "deploy:setup",           "deploy:db:create"
after "deploy:setup",           "nginx:setup", "nginx:reload"

namespace :deploy do
  namespace :assets do
    desc <<-DESC
      Run the asset precompilation rake task. You can specify the full path \
      to the rake executable by setting the rake variable. You can also \
      specify additional environment variables to pass to rake via the \
      asset_env variable. The defaults are:

        set :rake,      "rake"
        set :rails_env, "production"
        set :asset_env, "RAILS_GROUPS=assets"

      * only runs if assets have changed (add `-s force_assets=true` to force precompilation)
    DESC
    task :precompile, :roles => :web, :except => { :no_release => true } do
      begin
        from = source.next_revision(current_revision) # <-- Fail here at first-time deploy because of current/REVISION absence
      rescue
        err_no = true
      end
      if err_no || capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end
end

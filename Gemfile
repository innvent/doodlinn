source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'jquery-rails'
gem 'sqlite3'
gem 'twitter-bootstrap-rails'
gem 'annotate'
gem 'jquery-ui-bootstrap-rails'
gem 'capistrano-unicorn', :require => false, :git => 'git://github.com/sosedoff/capistrano-unicorn.git'
gem 'less-rails'

group :assets do
  gem 'therubyracer'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test do
  gem 'shoulda-matchers'
  gem 'rspec-rails'
end

group :staging, :production do
  gem 'unicorn'
  gem 'pg', '>= 0.14.1'
end

group :development, :test do
  gem 'capistrano'
end
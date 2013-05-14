source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '4.0.0.rc1'

gem 'jquery-rails'
gem 'pygments.rb'
gem 'twitter-bootstrap-rails'
gem 'warden-github'

group :development do
  gem 'foreman'
  gem 'sqlite3'
end

gem 'coffee-rails', '~> 4.0.0'
gem 'sass-rails', '~> 4.0.0.rc1'
gem 'uglifier', '>= 1.3.0'

# Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem 'less-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', :platforms => :ruby

gem 'turbolinks'
gem 'jbuilder', '~> 1.0.1'

# Use unicorn as the app server
group :production do
  gem 'pg'
  gem 'unicorn'
end

gem 'rspec', group: [ :test, :development ]

group :test do
  gem 'capybara'
  gem 'rspec-rails'
end

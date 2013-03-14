source 'https://rubygems.org'

gem 'rails', '3.2.12'
gem 'jquery-rails'
gem 'warden-github-rails'

# Use unicorn as the app server
group :production do
  gem 'pg'
# gem 'activerecord-postgresql-adapter'
  gem 'unicorn'
end

group :development do
  gem 'foreman'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'twitter-bootstrap-rails'
  gem 'uglifier', '>= 1.0.3'

  # Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
  gem 'less-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby
end

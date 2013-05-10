# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'

require_relative '../../config/environment'
require 'rspec/rails'
require 'rspec/autorun'

require 'capybara/rspec'

# Require all files in spec/features/support/
support_file_paths = File.expand_path('support/**/*.rb',
                                      File.dirname(__FILE__))
Dir[support_file_paths].each {|f| require f}

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
end

require 'features/helper'

# Require all files in spec/features/api/support/
support_file_paths = File.expand_path('support/**/*.rb',
                                      File.dirname(__FILE__))
Dir[support_file_paths].each {|f| require f}

module ApiHelpers
  include Rack::Test::Methods

  # App is a domain model and #app is a method that Rack::Test assumes will
  # exist and return a rack app. It's awkward that specs can't define an app
  # method which is why this module overrides
  # Rack::Test::Methods#build_rack_mock_session to look for #rack_app.
  def build_rack_mock_session
    Rack::MockSession.new(rack_app)
  end

  def rack_app
    Rails.application
  end
end

RSpec.configure do |config|
  config.include ApiHelpers, :type => :api
end

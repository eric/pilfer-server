module ApiExampleGroup
  def self.included(base)
    base.metadata[:type] = :api
  end
end

RSpec.configure do |config|
  config.include ApiExampleGroup, :type => :api, example_group: {
    file_path: /spec\/features\/api\//
  }

  config.before :type => :api do
    header 'Accept', 'application/json'
  end
end

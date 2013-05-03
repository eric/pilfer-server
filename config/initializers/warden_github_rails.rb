require 'warden/github'

Pilfer::Application.config.middleware.use Warden::Manager do |config|
  config.failure_app = lambda {|env| [403, {}, []]}
  config.default_strategies :github
  config.scope_defaults :default, :config => { :scope => 'user' }
end

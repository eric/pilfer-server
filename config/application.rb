require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Pilfer
  def self.secured?
    (ENV['GITHUB_AUTH_TEAM'].present? || ENV['GITHUB_AUTH_ORG'].present?)
  end

  def self.ignore_security?
    ENV['GITHUB_UNSECURED'].present?
  end

  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Heroku + twitter-bootstrap-rails + fontawesome doesn't play nicely.
    # https://github.com/seyhunak/twitter-bootstrap-rails/issues/535
    config.assets.precompile += %w( fontawesome-webfont.ttf
                                    fontawesome-webfont.eot
                                    fontawesome-webfont.svg
                                    fontawesome-webfont.woff )
  end
end

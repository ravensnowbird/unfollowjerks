require File.expand_path('../boot', __FILE__)
require 'rails/all'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Twitterapp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.assets.initialize_on_precompile = true

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    Twitter.configure do |config|
      config.consumer_key = ENV['twitter_config_key']
      config.consumer_secret = ENV['twitter_config_secret']
    end

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :user_name => "YOUR MailChimp EMAIL / USERNAME",
      :password => "YOUR MailChimp Password",
      :address => "smtp.mandrillapp.com",
      :port => 587,
      :authentication => :plain
    }

  end
end

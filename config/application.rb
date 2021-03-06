require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'bing_translator'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RorTest
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]

    config.i18n.available_locales = [:en, :he, :ru]
    config.i18n.default_locale = :en

    config.generators do |g|
      g.test_framework :rspec,
                       :fixtures => true,
                       :view_specs => false,
                       :helper_specs => false,
                       :routing_specs => false,
                       :controller_specs => true,
                       :request_specs => true
      g.fixture_replacement :factory_girl,
                            :dir => "spec/factories"
    end


    client_id = 'translation-service'
    client_secret = '+2r+EgXQVzg3TrR3kj00qES1wWSvFn9uR5FM3M8dJPE='
    azure_secret = 'yTgXjhgmC1cgAn4y7QjIemScvfpUgfF+W6Kb4ntM5Co'

    config.translator = BingTranslator.new(client_id, client_secret, false, azure_secret)
  end
end

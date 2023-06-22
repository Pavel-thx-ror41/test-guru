require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TestGuru
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Moscow" # active_support/values/time_zone.rb
    config.active_record.default_timezone = :local # https://learntutorials.net/ru/ruby-on-rails/topic/3367/изменение-часового-пояса-по-умолчанию
    # config.eager_load_paths << Rails.root.join("extras")
  end
end

require_relative "boot"

require "rails/all"
require 'rack/cors'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bookshop
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.active_job.queue_adapter = :sidekiq

    config.active_record.default_timezone = :utc

    config.middleware.insert_before(0, Rack::Cors) do
      allow do
        origins ['http://localhost:5173', 'https://hub.douglusnguyen.site', 'https://douglusnguyen.site']
        resource '*',
          headers: :any,
          methods: %i[get post patch put delete options],
          expose: ['Authorization', 'access-token', 'client', 'expiry', 'uid'],
          max_age: 600
      end
    end

    config.active_record.cache_versioning = false

    config.autoload_paths << Rails.root.join('lib')

    config.generators do |g|
      g.template_engine(nil)
      g.assets(false)
      g.helper(false)
      g.stylesheets(false)
    end

    config.logger = ActiveSupport::Logger.new(STDOUT)

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end

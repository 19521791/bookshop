Rails.application.configure do
  config.cache_classes = true

  # config.active_record.database_selector = { delay: 2.seconds }
  # config.active_record.database_resolver = ::ActiveRecord::Middleware::DatabaseSelector::Resolver
  # config.active_record.database_resolver_context = ::ActiveRecord::Middleware::DatabaseSelector::Resolver::Session
  config.eager_load = true
  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.action_cable.url = ENV['ACTION_CABLE_URL']
  config.action_cable.allowed_request_origins = ENV['ACTION_CABLE_ALLOWED_ORIGINS'].to_s.split

  config.action_mailer.logger = nil
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.compile = false
  config.action_dispatch.default_headers = {
    'X-Frame-Options' => 'SAMEORIGIN',
    'X-Content-Type-Options' => 'nosniff',
    'Referrer-Policy' => 'strict-origin-when-cross-origin',
    'Permissions-Policy' => 'your-permissions-policy-directives'
  }

  config.content_security_policy do |policy|
    # Default settings
    policy.default_src(:none)
    policy.script_src(:self, :unsafe_inline)
    policy.style_src(:self, :unsafe_inline)
    policy.img_src(:self, :data)
    policy.font_src(:self, :data)
    policy.connect_src(:self)
    policy.object_src(:none)
    policy.media_src(:self)
    policy.frame_src(:none)

    # Additional directives (optional)
    policy.script_src('https://www.google-analytics.com')
    policy.style_src('https://fonts.googleapis.com')
    policy.img_src('https://www.example.com')
  end

  config.log_level = :debug

  config.log_tags = [:request_id]

  config.logger = ActiveSupport::Logger.new("log/#{Rails.env}.log")

  config.action_controller.perform_caching = true

  config.cache_store = :redis_store

  config.action_mailer.perform_caching = false

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new

  config.active_record.dump_schema_after_migration = false
end

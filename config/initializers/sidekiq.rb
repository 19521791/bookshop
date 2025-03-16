require 'sidekiq'
require 'sidekiq/web'

Sidekiq.strict_args!(false)
Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  Rack::Utils.secure_compare(
    ::Digest::SHA256.hexdigest(user),
    ::Digest::SHA256.hexdigest(::ENV.fetch('SIDEKIQ_USER', nil))
  ) &
    Rack::Utils.secure_compare(
      ::Digest::SHA256.hexdigest(password),
      ::Digest::SHA256.hexdigest(::ENV.fetch('SIDEKIQ_PASSWORD', nil))
    )
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: ENV.fetch('REDIS_URL', nil),
    password: ENV.fetch('REDIS_PASSWORD', nil),
    ssl: ENV.fetch('REDIS_SSL', nil)
  }
end

Sidekiq.configure_server do |config|
  config.redis = {
    url: ENV.fetch('REDIS_URL', nil),
    password: ENV.fetch('REDIS_PASSWORD', nil),
    ssl: ENV.fetch('REDIS_SSL', nil)
  }
end
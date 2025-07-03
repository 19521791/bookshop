# frozen_string_literal: true

# if ::Rails.env.to_s.in?(%w[production staging])
#   Sentry.init do |config|
#   config.dsn = ENV["SENTRY_DNS"]
#   config.breadcrumbs_logger = [:active_support_logger, :http_logger]
#   config.traces_sample_rate = 1.0
#   config.traces_sampler = lambda do |context|
#      true
#   end
# end

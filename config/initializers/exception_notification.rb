# unless Rails.env.development?
#   Rails.application.config.middleware.use(
#     ExceptionNotification::Rack,
#     email: {
#       email_prefix: "[Portfolio API #{Rails.env}]",
#       sender_address: ENV.fetch('EMAIL', nil),
#       exception_recipients: %w[toannguyenvan145@gmail.com]
#     },
#     telegram: {
#       token: ENV.fetch('TELEGRAM_TOKEN', nil),
#       channel: ENV.fetch('TELEGRAM_CHANNEL', nil)
#     }
#   )
# end

Rails.application.config.middleware.use(
  ExceptionNotification::Rack,
  email: {
    email_prefix: "[Portfolio API #{Rails.env}]",
    sender_address: ENV.fetch('EMAIL', nil),
    exception_recipients: %w[toannguyenvan145@gmail.com]
  }
  # telegram: {
  #   token: ENV.fetch('TELEGRAM_TOKEN', nil),
  #   channel: ENV.fetch('TELEGRAM_CHANNEL', nil)
  # }
)

if Rails.env.staging?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    domain: 'gmail.com',
    user_name: ENV.fetch('EMAIL', nil),
    password: ENV.fetch('EMAIL_PASSWORD', nil),
    authentication: 'login',
    enable_starttls_auto: true
  }
end

if Rails.env.development?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    domain: 'gmail.com',
    user_name: ENV.fetch('EMAIL', nil),
    password: ENV.fetch('EMAIL_PASSWORD', nil),
    authentication: 'plain',
    enable_starttls_auto: true
  }
end

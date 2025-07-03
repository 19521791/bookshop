class ApplicationMailer < ActionMailer::Base
  default from: "Portfolio <#{ENV.fetch('EMAIL', nil)}>"
  layout "mailer"
end

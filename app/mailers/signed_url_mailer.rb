class SignedUrlMailer < ApplicationMailer
  def tracking_errors
    email = 'toannguyenvan145@gmail.com'
    mail(to: email, bcc: [ENV.fetch('EMAIL', nil)], subject: "Testing setup mail")
  end  
end

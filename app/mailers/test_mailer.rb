class TestMailer < ApplicationMailer
  default from: ENV.fetch('EMAIL', nil)

  def alert_email
    mail(
      to: '19521791@gm.uit.edu.vn',
      subject: '[TestMailer] Gửi thử email từ Rails',
      content_type: 'text/html'      
    )
  end
end

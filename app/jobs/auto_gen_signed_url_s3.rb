class AutoGenSignedUrlS3 < ApplicationJob
  queue_as :default

  def perform
    attachments&.each do |attachment|
      presigned_url = aws_service.generate_presigned_url(attachment.file_name)

      expired_at_vn = ::Utils.parse_expired_time(presigned_url)

      attachment.update(signed_url: presigned_url, expired_at: expired_at_vn)

      ::ActionCable.server.broadcast(
        "signed_urls_channel",
        { key: ::FILE_NAMES[attachment.file_name], signed_url: presigned_url, type: 'SIGNED_URLS_UPDATE' }
      )
    end
  end

  private

  def aws_service
    @aws_service ||= ::AwsService.new
  end

  def attachments
    ::Attachment.where("expired_at BETWEEN ? AND ?", ::Time.current, 12.hours.from_now)
  end
end

class AutoGenSignedUrlS3 < ApplicationJob
  queue_as :default

  def perform
    return if attachments.empty?

    attachments.each do |attachment|
      presigned_url = cloudfront_service.generate_presigned_url(attachment.file_name)

      expired_at = ::Utils.parse_expired_time(presigned_url)

      attachment.update(signed_url: presigned_url, expired_at:)
    end
  end

  private

  def cloudfront_service
    ::CloudFrontService.new
  end

  def attachments
    ::Attachment.where(
      "expired_at <= :now OR expired_at BETWEEN :now AND :later OR expired_at IS NULL",
      now: Time.current,
      later: 12.hours.from_now
    )
  end  
end

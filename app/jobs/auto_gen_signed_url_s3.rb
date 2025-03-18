class AutoGenSignedUrlS3 < ApplicationJob
  queue_as :default

  def perform
    attachments&.each do |attachment|
      presigned_url = aws_service.generate_presigned_url(attachment.file_name)

      expired_at_vn = parse_expired_time(presigned_url)

      attachment.update(signed_url: presigned_url, expired_at: expired_at_vn)

      ::ActionCable.server.broadcast(
        "signed_urls_channel",
        { key: ::FILE_NAMES[attachment.file_name], signed_url: presigned_url, type: 'SIGNED_URLS_UPDATE' }
      )
    end
  end

  private

  def check_expired_time(expired_at)
    expired_at.to_date == ::Date.tomorrow
  end

  def parse_expired_time(signed_url)
    query_params = ::URI.parse(signed_url).query
    params_hash = ::URI.decode_www_form(query_params).to_h

    amz_date = params_hash['X-Amz-Date']
    created_at = ::Time.strptime(amz_date, '%Y%m%dT%H%M%SZ').in_time_zone('UTC')

    expired_at = params_hash['X-Amz-Expires'].to_i
    (created_at + expired_at.seconds)
  end

  def aws_service
    @aws_service ||= ::AwsService.new
  end

  def attachments
    ::Attachment.where("expired_at BETWEEN ? AND ?", ::Time.current, 5.hours.from_now)
  end
end

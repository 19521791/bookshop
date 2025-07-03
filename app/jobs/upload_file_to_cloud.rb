class UploadFileToCloud < ApplicationJob
  queue_as :default
  
  rescue_from(StandardError) do |exception|
    ::Utils.logger_color("Upload failed: #{exception.message}")
  end

  def perform(file_params)
    @file_params = file_params.with_indifferent_access
    upload_file_to_s3  
  end

  private

  attr_reader :file_params

  def aws_service
    @aws_service ||= ::AwsService.new
  end

  def s3_response
    @s3_response ||= begin
      start_time = ::Time.current
      result = aws_service.upload_file(
        file: prepare_file,
        file_name: file_params[:original_filename],
        content_type: file_params[:content_type]
      ) 
      ::Utils.logger_color("S3 Upload took: #{Time.current - start_time}s")
      result
    end
  end

  def prepare_file
    ::File.open(file_params[:tempfile_path])
  end

  def upload_file_to_s3
    return unless s3_response[:success]

    signed_url = s3_response.dig(:data, :signed_url)

    ::Attachment.create(
      file_name: file_params[:original_filename],
      signed_url: signed_url,
      container: 'aws-s3',
      expired_at: ::Utils.parse_expired_time(signed_url)
    )
  rescue ::ActiveRecord::RecordInvalid => e
    ::Utils.logger_color("Failed to create attachment: #{e.message}")
  end
end

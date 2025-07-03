class AwsService
  attr_reader :s3_client, :bucket

  def initialize(bucket = ENV.fetch('AWS_BUCKET'))
    @s3_client = Aws::S3::Client.new
    @bucket = bucket
  end

  def generate_presigned_url(object_key, expires_in: 7.days.to_i)
    signer = Aws::S3::Presigner.new(client: s3_client)
    signer.presigned_url(:get_object, bucket: bucket, key: object_key, expires_in: expires_in)
  end

  def upload_file(file:, file_name:, content_type:, bucket: nil)
    bucket ||= @bucket
    begin
      s3_client.put_object(
        bucket: bucket,
        key: file_name,
        body: file,
        content_type: content_type
      )

      { success: true, object_key: file_name }
    rescue ::Aws::S3::ServiceError => e
      { success: false, errors: e.message }
    end
  end

  def delete_file(object_key)
    
      s3_client.delete_object(
        bucket: bucket,
        key: object_key
      )

      { success: true }
  rescue ::Aws::S3::Errors::ServiceError => e
      { success: false, errors: e.message }
    
  end

  def file_exists?(object_key)
    
      s3_client.head_object(bucket: bucket, key: object_key)
      true
  rescue ::Aws::S3::Errors::NotFound
      false
  end

  def head_object(object_key)
    s3_client.head_object(
      bucket: ENV.fetch('AWS_BUCKET', nil),
      key: object_key
    )
  end
end

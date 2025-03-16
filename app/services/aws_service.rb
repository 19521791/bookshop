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

  def upload_file(file, object_key)
    s3_client.put_object(
      bucket: bucket,
      key: object_key,
      body: file
    )
  end

  def delete_file(object_key)
    s3_client.delete_object(
      bucket: bucket,
      key: object_key
    )
  end
end
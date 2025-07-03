require 'aws-sdk-cloudfront'

class CloudFrontService
  attr_reader :signer, :bucket

  def initialize(bucket = ENV.fetch('AWS_BUCKET', nil))
    @bucket = bucket
    @signer = Aws::CloudFront::UrlSigner.new(
      key_pair_id: ENV.fetch('CLOUDFRONT_KEY_PAIR_ID'),
      private_key: OpenSSL::PKey::RSA.new(Base64.decode64(ENV.fetch('CLOUDFRONT_PRIVATE_KEY', nil)))
    )
  end

  def generate_presigned_url(object_key, expires_in: 7.days.to_i)
    url = "#{ENV.fetch('CLOUDFRONT_DOMAIN', nil)}/#{object_key}"
    @signer.signed_url(url, expires: Time.now + expires_in)
  end
end

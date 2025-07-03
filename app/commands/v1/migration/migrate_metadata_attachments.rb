require 'aws-sdk-s3'
require 'digest'

module V1
  module Migration
    class MigrateMetadataAttachments
      prepend ::SimpleCommand

      def call
        migrate_metadata
      end

      def s3_service
        @s3_service ||= ::AwsService.new
      end

      def cloudfront_service
        ::CloudFrontService.new
      end

      def migrate_metadata
        total_processed = 0
        total_failed = 0

        ::Attachment.where(file_key: nil).find_in_batches(batch_size: BATCH_SIZE) do |batch|
          ActiveRecord::Base.transaction do
            batch.each do |attachment|
              with_retries(attachment) do
                process_attachment(attachment)
                total_processed += 1
              rescue ::Aws::S3::Errors::NotFound => e
                log_error(attachment, "File not found: #{e.message}")
                total_failed += 1
              end
            end
          end
        end

        log_summary(total_processed, total_failed)
      end

      def with_retries(attachment)
        retries = 0
        begin
          yield
        rescue ::StandardError => e
          retries += 1
          if retries <= MAX_RETRIES
            sleep SLEEP_INTERVAL
            retry
          end
          log_error(attachment, "Failed after #{MAX_RETRIES} retries: #{e.message}")
          raise if retries > MAX_RETRIES
        end
      end

      def process_attachment(attachment)
        uri = URI.parse(attachment.signed_url)
        object_key = URI.decode_www_form_component(uri.path[1..])

        resp_info_object = s3_service.head_object(object_key)
        cloudfront_signed_url = generate_cloudfront_url(attachment)

        attachment.update!(
          signed_url: cloudfront_signed_url,
          file_key: object_key,
          file_size: resp_info_object.content_length,
          content_type: resp_info_object.content_type,
          checksum: calculate_checksum(resp_info_object.etag),
          metadata: build_metadata(resp_info_object)
        )

        log_success(attachment, object_key)
      rescue ::StandardError => e
        log_error(attachment, "Processing failed: #{e.message}")
        raise
      end

      def generate_cloudfront_url(attachment)
        object_key = attachment.file_key || attachment.file_name
        
        cloudfront_service.generate_presigned_url(object_key)
      end

      def calculate_checksum(etag)
        etag.gsub('"', '')
      end

      def build_metadata(resp)
        {
          'etag' => resp.etag,
          'last_modified' => resp.last_modified,
          'storage_class' => resp.storage_class
        }.compact
      end

      def log_success(attachment, object_key)
        ::Utils.logger_color("[Migration] Updated attachment #{attachment.id}: #{object_key}")
      end

      def log_error(attachment, message)
        ::Utils.logger_color("[Migration] Error with attachment #{attachment&.id}: #{message}")
      end

      def log_summary(processed, failed)
        message = "Migration completed! Processed: #{processed}, Failed: #{failed}"
        puts message
        ::Utils.logger_color("[Migration] #{message}")
      end
    end
  end
end

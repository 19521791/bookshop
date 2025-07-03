module V1
  module Aws
    class CheckConsistentS3Object
      prepend ::SimpleCommand

      attr_reader :s3_service, :bucket, :inconsistent_records, :destroyed_records

      def initialize
        @s3_service = ::AwsService.new
        @bucket = ::ENV.fetch('AWS_BUCKET', nil)
        @inconsistent_records = []
        @destroyed_records = []
      end

      def call
        check_consistency

        destroy_inconsistent_records if ENV.fetch('AUTO_DELETE', nil) == 'true'

        {
          total_records: attachments.count,
          total_inconsistent_records: inconsistent_records.size,
          destroyed_records_count: destroyed_records.size,
          details: handle_detail_inconsistent_record
        }
      end

      private

      def attachments
        @attachments ||= ::Attachment.all
      end

      def check_consistency
        attachments.find_each do |attachment|
          object_key = extract_object_key(attachment)

          s3_service.head_object(object_key)
        rescue ::Aws::S3::Errors::NotFound
          log_inconsistent_record(attachment, object_key)
        rescue ::StandardError => e
          ::Utils.logger_color("Failed when checked record #{attachment.id}: #{e.message}", :red)
        end
      end

      def destroy_inconsistent_records
        return if inconsistent_records.empty?

        ::Utils.logger_color("===== DELETING INCONSISTENT RECORDS =====", :yellow)
        
        inconsistent_records.each do |record|
          attachment = Attachment.find_by(id: record[:id])
          next unless attachment

          if attachment.destroy
            destroyed_records << record
            ::Utils.logger_color("Deleted record #{record[:id]} - #{record[:file_name]}", :green)
          else
            ::Utils.logger_color("Failed to delete record #{record[:id]}: #{attachment.errors.full_messages}", :red)
          end
        end
      end

      def extract_object_key(attachment)
        if attachment.file_key.present?
          attachment.file_key
        else
          URI.decode_www_form_component(URI.parse(attachment.signed_url).path[1..])
        end
      end

      def log_inconsistent_record(attachment, object_key)
        inconsistent_records << {
          id: attachment.id,
          file_name: attachment.file_name,
          object_key: object_key,
          signed_url: attachment.signed_url
        }
        ::Utils.logger_color("File '#{object_key}' doesn't exist in S3", :yellow)
      end

      def handle_detail_inconsistent_record
        if inconsistent_records.any?
          inconsistent_records.each do |record|
            {
              id: record[:id],
              file_name: record[:file_name],
              object_key: record[:object_key],
              signed_url: record[:signed_url]
            }
          end
        else
          {
            message: 'All files exist in S3'
          }
        end
      end
    end
  end
end

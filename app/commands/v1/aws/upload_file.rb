module V1
  module Aws
    class UploadFile
      prepend ::SimpleCommand

      attr_reader :params, :file

      def initialize(params)
        @params = params
        @file = params[:file]
      end

      def call
        return errors.add(:file, ::I18nt.call('errors.required')) unless file

        attachment = check_existing_attachment

        return { file_name: attachment.file_name, signed_url: attachment.signed_url } if attachment

        upload_file_to_s3
      end

      private

      def s3_service
        ::AwsService.new
      end

      def cloudfront_service
        ::CloudFrontService.new
      end

      def check_existing_attachment
        ::Attachment.find_by(file_name: file.original_filename)
      end

      def upload_file_to_s3
        if s3_response[:success]
          attachment = build_attachment_record

          signed_url = cloudfront_service.generate_presigned_url(file.original_filename)

          if attachment.persisted?
            attachment.update!(
              signed_url: signed_url,
              expired_at: ::Utils.parse_expired_time(signed_url)
            )
            { file_name: file.original_filename, signed_url:, expired_at: ::Utils.parse_expired_time(signed_url) }
          else
            errors.add(:attachment, ::I18n.t('errors.failed_saving'))
            nil
          end
        else
          errors.add(:s3_upload, s3_response.errors)
          nil
        end
      end

      def s3_response
        @s3_response ||= begin
          start_time = ::Time.current
          result = s3_service.upload_file(
            file: file,
            file_name: file.original_filename,
            content_type: file.content_type
          )
          ::Utils.logger_color("S3 Upload took: #{Time.current - start_time}s")
          result
        end
      end

      def build_attachment_record
        ::Attachment.create(
          file_name: file.original_filename.gsub(' ', '_'),
          container: 'aws-s3',
          content_type: file.content_type
        )
      end
    end
  end
end

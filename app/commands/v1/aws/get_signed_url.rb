module V1
  module Aws
    class GetSignedUrl
      prepend ::SimpleCommand
      attr_reader :attachments
  
      def call
        if ::Rails.env.staging?
          {
            records: attachments.map { |attachment| presenter(attachment) }
          }
        else
          {
            records:attachments.map { |attachment| dev_presenter(attachment) }
          }
        end
      end
  
      def presenter(attachment)
        {
          key: ::Utils.key_from_filename(attachment.file_name),
          signed_url: attachment.signed_url
        }
      end

      def dev_presenter(attachment)
        {
          key: ::Utils.key_from_filename(attachment.file_name),
          signed_url: chain_signed_url(attachment.file_name)
        }
      end

      def chain_signed_url(file_name)
        base_url = ::ENV.fetch('LOCAL_PATH', nil)
        "#{base_url}/#{file_name}"
      end

      def attachments
        @attachments ||= ::Attachment.all
      end
    end
  end
end

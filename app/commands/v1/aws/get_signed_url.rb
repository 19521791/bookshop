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
            records:attachments.map { |attachment| {
              key: ::FILE_NAMES[attachment.file_name],
              signed_url: chain_signed_url(attachment.file_name)
            }}
          }
        end
      end
  
      def presenter(attachment)
        {
          key: ::FILE_NAMES[attachment.file_name],
          signed_url: attachment.signed_url
        }
      end

      def chain_signed_url(file_name)
        base_url = 'http://image.douglusnguyen.site/local-assets'
        "#{base_url}/#{file_name}"
      end

      def attachments
        @attachments ||= ::Attachment.all
      end
    end
  end
end
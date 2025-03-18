module V1
  class GetSignedUrl
    prepend ::SimpleCommand

    def call
      {
        records: ::Attachment.all.map { |attachment| presenter(attachment) }
      }
    end

    def presenter(attachment)
      {
        key: ::FILE_NAMES[attachment.file_name],
        signed_url: attachment.signed_url
      }
    end
  end
end
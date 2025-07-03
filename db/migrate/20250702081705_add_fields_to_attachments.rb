class AddFieldsToAttachments < ActiveRecord::Migration[7.0]
  def change
    add_column :attachments, :file_key, :string, comment: "Object key in S3"
    add_column :attachments, :checksum, :string, limit: 64, comment: "MD5/SHA1 checksum for deduplication"
    add_column :attachments, :file_size, :bigint, comment: "File size in bytes"
    add_column :attachments, :content_type, :string, comment: "MIME type of the file"
    add_column :attachments, :metadata, :jsonb, default: {}, comment: "Additional metadata"
  end
end

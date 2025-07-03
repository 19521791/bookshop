# == Schema Information
#
# Table name: attachments
#
#  id                                            :bigint           not null, primary key
#  checksum(MD5/SHA1 checksum for deduplication) :string(64)
#  container                                     :text
#  content_type(MIME type of the file)           :string
#  expired_at                                    :datetime
#  file_key(Object key in S3)                    :string
#  file_name                                     :string
#  file_size(File size in bytes)                 :bigint
#  metadata(Additional metadata)                 :jsonb
#  signed_url                                    :string
#  created_at                                    :datetime         not null
#  updated_at                                    :datetime         not null
#
class Attachment < ApplicationRecord
end

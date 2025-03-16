# == Schema Information
#
# Table name: attachments
#
#  id         :bigint           not null, primary key
#  container  :text
#  expired_at :datetime
#  file_name  :string
#  signed_url :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Attachment < ApplicationRecord
end

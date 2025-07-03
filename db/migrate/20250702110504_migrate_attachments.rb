class MigrateAttachments < ActiveRecord::Migration[7.0]
  def change
    ::V1::Migration::MigrateMetadataAttachments.call
  end
end

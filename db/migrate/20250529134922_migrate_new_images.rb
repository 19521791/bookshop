class MigrateNewImages < ActiveRecord::Migration[7.0]
  def change
    V1::Migration::MigrateScreenshotImages.call
    AutoGenSignedUrlS3.perform_now
  end
end

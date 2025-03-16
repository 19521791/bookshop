class MigrateSignedUrl < ActiveRecord::Migration[7.0]
  def change
    ::V1::Migration::MigrateSignedUrl.call
  end
end

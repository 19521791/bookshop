class CreateAttachment < ActiveRecord::Migration[7.0]
  def change
    create_table(:attachments) do |t|
      t.string(:file_name)
      t.text(:container)
      t.string(:signed_url)
      t.datetime(:expired_at)

      t.timestamps
    end
  end
end

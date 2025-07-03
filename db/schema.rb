# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2025_07_02_110504) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string "file_name"
    t.text "container"
    t.string "signed_url"
    t.datetime "expired_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_key", comment: "Object key in S3"
    t.string "checksum", limit: 64, comment: "MD5/SHA1 checksum for deduplication"
    t.bigint "file_size", comment: "File size in bytes"
    t.string "content_type", comment: "MIME type of the file"
    t.jsonb "metadata", default: {}, comment: "Additional metadata"
  end

end

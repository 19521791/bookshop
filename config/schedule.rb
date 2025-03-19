require_relative 'environment'
set :environment, ::Rails.env
set :TZ, "Asia/Ho_Chi_Minh"

set :output, "log/cron.log"

# every 1.day, at: '23.59 pm' do
#   runner 'AutoGenSignedUrlS3.perform_later'
# end
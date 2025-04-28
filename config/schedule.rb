require_relative 'environment'
set :environment, ::Rails.env
set :TZ, "Asia/Ho_Chi_Minh"

env :PATH, '/home/staging/.rbenv/shims:/home/staging/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin'

set :output, "log/cron.log"

every 1.day, at: '23.59 pm' do
  runner 'AutoGenSignedUrlS3.perform_later'
end

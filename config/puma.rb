unless Rails.env.development?
  require 'puma/daemon'
  bind "unix:///home/development/bookshop/rails/current/tmp/sockets/puma.shock"
end

threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count

bind "unix:///home/development/bookshop/rails/current/tmp/sockets/puma.shock" unless Rails.env.development?

port ENV.fetch("PORT") { 3000 }

environment ENV.fetch("RAILS_ENV") { "development" }

pidfile ENV.fetch("PIDFILE") { "tmp/pids/puma.pid" }

workers ENV.fetch("WEB_CONCURRENCY") { 2 }

preload_app!

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

plugin :tmp_restart

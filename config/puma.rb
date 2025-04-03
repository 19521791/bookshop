workers ENV.fetch("WEB_CONCURRENCY") {2}
threads_count = ENV.fetch("RAILS_MAX_THREAD") {5}
threads threads_count, threads_count

unless ::Rails.env.development?
  bind "unix:///home/staging/bookshop/rails/current/tmp/sockets/puma.sock"

  umask 00007
end

preload_app!

threads_count = ::ENV.fetch("RAILS_MAX_THREADS", 5)
threads threads_count, threads_count

rackup DefaultRackup
port ENV.fetch("PORT") { 3000 }

environment ENV.fetch("RAILS_ENV") { "staging" }

pidfile ENV.fetch("PIDFILE") { "tmp/pids/puma.pid" }

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

plugin :tmp_restart

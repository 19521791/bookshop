workers ENV.fetch("WEB_CONCURRENCY") {2}
threads_count = ENV.fetch("RAILS_MAX_THREAD") {5}
threads threads_count, threads_count

bind "tcp://127.0.0.1:3000"

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

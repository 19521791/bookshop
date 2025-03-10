# config valid for current version and patch releases of Capistrano
set :repo_url, "git@github.com:19521791/bookshop.git"
set :rbenv_ruby, '3.1.2'
set :rbenv_prefix, '/usr/bin/rbenv exec'
set :defaut_env, { path: "~/.rbenv/shim:~/.rbenv/bin:$PATH" }

set :init_system, :systemd
set :puma_threads, [4, 16]
set :puma_workers, 2

# config/secrets.yml
set :keep_releases, 3
set :linked_files, %w[
  puma.rb
  config/database.yml
  .env
]

set :linked_dirs,
  %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system]

set :pty, false

set :ssh_options, { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/hawkhost_rsa) }

set :conditionally_migrate, true
namespace :puma do
  task :start do
    on roles(:app) do
      within current_path do
        execute :bundle, "exec pumactl -F $(pwd)/config/puma.rb stop"
      end
    end
  end
  task :stop do
    on roles(:app) do
      within current_path do
        execute :bundle, "exec pumactl -F $(pwd)/config/puma.rb stop"
      end
    end
  end
  task :restart do
    on roles(:app) do
      within current_path do
        execute :echo, 'BEGIN tmp/pids/puma.pid &'
        execute :cat, 'tmp/pids/puma.pid &'
        execute :bundle, "exec pumactl -S $(pwd)/tmp/pids/puma.state -F $(pwd)/puma.rb"
        execute :cat, 'tmp/pids/puma.pid &'
        execute :echo, 'END tmp/pids/puma.pid &'
      end
    end
  end
end

namespace :sidekiq do
  task :quite do
    on roles(:app) do
      within current_path do
        execute :sudo, "systemctl kill -s TSTP sidekiq"
      end
    end
  end
  task :stop do
    on roles(:app) do
      within current_path do
        execute :sudo, "systemctl stop sidekiq"
      end
    end
  end
  task :start do
    on roles(:app) do
      within current_path do
        execute :sudo, "systemctl start sidekiq"
      end
    end
  end
  task :restart do
    on roles(:app) do
      within current_path do
        execute :sudo, "systemctl restart sidekiq"
      end
    end
  end
end

namespace :deploy do
  before :starting, "sidekiq:quite"
  after :finishing, "sidekiq:restart"
  after 'deploy:cleanup', "puma:restart"
  after 'deploy:failed', 'sidekiq:restart'
end
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

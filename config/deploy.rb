# config valid for current version and patch releases of Capistrano
set :repo_url, "git@github.com:19521791/bookshop.git"
set :rbenv_ruby, '3.1.2'
set :rbenv_prefix, '/usr/bin/rbenv exec'
set :defaut_env, { path: "~/.rbenv/shim:~/.rbenv/bin:$PATH" }

set :init_system, :systemd
set :puma_threads, [4, 16]
set :puma_workers, 2
set :user, "staging"

# config/secrets.yml
set :keep_releases, 3
set :linked_files, %w[
  config/puma.rb
  config/database.yml
  .env
]

set :linked_dirs,
  %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system]

set :pty, false

set :ssh_options, { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa_server) }

set :conditionally_migrate, true
namespace :puma do
  desc 'Start Puma'
  task :start do
    on roles(:app) do
      within current_path do
        execute :echo, "Starting Puma..."
        execute :sudo, :systemctl, "start puma.service"
      end
    end
  end
  desc 'Stop Puma'
  task :stop do
    on roles(:app) do
      within current_path do
        execute :echo, "Stopping Puma..."
        execute :sudo, :systemctl, "stop puma.service"
      end
    end
  end
  desc 'Restart Puma'
  task :restart do
    on roles(:app) do
      within current_path do
        execute :sudo, :systemctl, "restart puma.service"
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
  desc "Create Puma config file"
  task :setup_puma do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config" unless test("[ -f #{shared_path}/config/puma.rb ]")
      upload! "config/puma.rb", "#{shared_path}/config/puma.rb" unless test("[ -f #{shared_path}/config/puma.rb ]")
    end
  end

  before :starting, "sidekiq:quite"
  before :check, "setup_puma"
  after :finishing, "sidekiq:restart"
  after :finishing, "puma:restart"
  after :failed, "sidekiq:restart"
end


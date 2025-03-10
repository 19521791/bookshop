set :rbenv_prefix, %(RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)})
set :deploy_user, 'development'
set :stage, :staging
set :branch, 'main'
set :rbenv_ruby, '3.1.2'
set :application, 'bookshop'
set :server_name, 'dev.douglus.com'
server '172.96.190.154', user: 'development', roles: %w[web app db], primary: true
set :deploy_to, "/home/#{fetch(:deploy_user)}/#{fetch(:application)}/rails/current"
set :rails_env, :staging
set :environment, :staging
set :enable_ssl, false

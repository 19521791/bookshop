set :rbenv_prefix, "RBENV_ROOT=$HOME/.rbenv RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :deploy_user, 'staging'
set :stage, :staging
set :branch, 'main'
set :rbenv_ruby, '3.1.2'
set :application, 'bookshop'
set :server_name, 'dev.douglus.com'
server '157.66.101.5', user: 'staging', roles: %w[web app db], primary: true
set :deploy_to, "/home/#{fetch(:deploy_user)}/#{fetch(:application)}/rails"
set :puma_conf, "#{shared_path}/config/puma.rb"
set :rails_env, :staging
set :environment, :staging
set :enable_ssl, false

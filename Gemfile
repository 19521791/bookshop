source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.8"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.1.0", ">= 4.1.0"

gem 'simple_command'

gem 'rack-cors', :require => 'rack/cors'

gem "faker"
# Speed up commands on slow machines / big apps [https://github.com/rails/spring]
# gem "spring"

gem 'pagy'

gem 'kaminari'

gem "friendly_id"

gem "bcrypt", "~> 3.1.7"

gem 'jwt'

gem 'dotenv-rails'

gem 'pry'
gem 'pry-rails'

gem 'concurrent-ruby', '1.3.4'

gem 'aws-sdk-cloudfront'

gem 'exception_notification'
gem 'exception_notification_telegram'

gem 'addressable'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

gem "sidekiq", "~> 7.0.9"
gem "redis-rails"
gem "redis-namespace", "~> 1.5", ">= 1.5.2"

gem 'aws-sdk-s3'

gem "rubocop"

gem 'whenever', require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  gem 'annotate'

  gem 'capistrano', '~> 3.17'
  
  gem 'capistrano-rails', '~> 1.6'

  gem 'capistrano-rbenv', '~> 2.2'

  gem 'capistrano-bundler', '~> 2.0'

  gem 'capistrano3-puma', '~> 5.2'
  
  gem 'capistrano-sidekiq', '~> 2.0'

  gem 'derailed_benchmarks'

  gem 'syntax_suggest'

  gem 'faraday'

end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"

end

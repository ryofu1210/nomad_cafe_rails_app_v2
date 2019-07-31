source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.3.3'

gem 'rails', '~> 5.2.3'
gem 'mysql2', '>= 0.3.18', '< 0.6.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'mini_racer', platforms: :ruby
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'annotate'
gem 'devise'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'carrierwave'
gem 'rmagick'
gem 'slim-rails'
gem 'html2slim'
gem 'kaminari'
gem 'enum_help'
gem 'rails-i18n', '~> 5.1'
gem 'webpacker', github: 'rails/webpacker'
gem 'active_hash'
gem 'redis-rails'
gem 'impressionist'
gem 'jquery-rails'
gem 'font-awesome-rails'
gem 'breadcrumbs_on_rails'
gem "bootstrap", ">= 4.3.1"
gem 'cancancan'
gem 'unicorn'
gem 'fog'
gem 'dotenv-rails'

# 矯正ツール
gem 'rubocop', require: false # Rails校正ツール


# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'pry'
  gem 'pry-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  
  # 開発環境用メール配信ツール
  gem 'letter_opener' 
  gem 'letter_opener_web'
  gem 'spring-commands-rspec'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  # gem 'chromedriver-helper'
  gem 'webdrivers' unless ENV.key?('CIRCLECI')
  gem "shoulda-matchers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

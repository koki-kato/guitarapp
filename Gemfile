source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.4'

gem 'rails', '~> 6.1.5', '>= 6.1.5.1'
gem 'rails-i18n'
gem 'bcrypt'
gem 'faker'
gem 'roo'
gem 'rounding'
# gem 'devise' # LINEログイン用
# gem 'omniauth-line' # LINEログイン用
# gem 'omniauth-rails_csrf_protection' # LINEログイン用
gem 'omniauth'
# gem 'omniauth-twitter' #twitter用
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection' #twitter用
gem 'dotenv-rails' #外部連携用
gem 'bootstrap', '~> 4.3.1'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'will_paginate'
gem 'will_paginate-bootstrap'
gem "sprockets-rails"
gem 'mysql2', '~> 0.5'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

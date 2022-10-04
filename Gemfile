# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'bootsnap', require: false
gem 'importmap-rails'
gem 'jbuilder'
gem 'kaminari', '~> 1.2'
gem 'pg', '~> 1.4'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4'
gem 'redis', '~> 4.0'
gem 'rest-client', '~> 2.1'
gem 'sidekiq', '~> 6.5'
gem 'sidekiq-scheduler', '~> 4.0'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'rubocop', '~> 1.36', require: false
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'rspec', '~> 3.11'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

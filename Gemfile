# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.4"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "tailwindcss-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Sass to process CSS
gem 'sassc-rails'

# Authentication
gem 'devise'

# Multi tenant
gem 'ros-apartment', require: 'apartment'

# ransack filters
gem 'ransack'

# authorization system
gem 'pundit'

# paginate
gem 'kaminari'

# Data dummy generator
gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'

gem 'vanilla_nested'

gem 'friendly_id'

# Data dummy generator
gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'

gem 'blacklist_validator'

gem 'money-rails'

gem 'city-state'
gem 'countries'

gem 'money-open-exchange-rates'

gem 'google_currency', '~> 3.4', '>= 3.4.1'

gem 'money'

gem 'open_exchange_rates'

gem 'iso_country_codes'

gem 'deep_cloneable', '~> 3.2.0'

gem "chartkick"

gem "punching_bag"

gem 'acts_as_votable'

gem 'roo'

# aasm
gem 'aasm'


# Uploader
gem 'image_processing'
gem 'mini_magick'
gem 'shrine', '~> 3.0'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # Models schema comment
  gem 'annotate', '3.2.0'
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  # Local mailer
  gem 'letter_opener'
end

group :development do
  # Use Capistrano for deployment
  gem 'capistrano'
  gem 'capistrano3-puma', github: 'seuros/capistrano-puma'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rails-console'
  gem 'capistrano-rbenv'

  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  gem 'foreman'
  # Code review
  gem 'rubocop', require: false
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'cssbundling-rails'

# Generate PDF
gem 'wicked_pdf'
# gem 'wkhtmltopdf-binary'
gem 'grover'
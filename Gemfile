# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.0"

# Core
gem "rails", "~> 5.2.0"
gem "bootsnap", ">= 1.1.0", require: false
gem "puma", "~> 3.11"
gem "sitemap_generator"
gem "httparty"
gem "validate_url"
gem "chronic"
gem "config"
gem "erubis"
gem "friendly_id", "~> 5.1.0"
gem "wicked"
gem "sidekiq"

# Analytics
gem "ahoy_matey"
gem "analytics-ruby"
gem "blazer"
gem "groupdate"

# Databases
gem "pg", ">= 0.18", "< 2.0"
gem "redis"
gem "redis-namespace"
gem "redis-rails"
gem "redis-rack-cache"

# Phone Tools
gem "nexmo"
gem "phonelib"
gem "iso_country_codes"

gem "rack-mini-profiler"

# Pagination
gem "kaminari", github: "kaminari/kaminari", branch: "master"

# Active Record
gem "store_base_sti_class"

# Authentication
gem "devise"
gem "devise-async"
gem "rolify"
gem "pundit"

# SEO
gem "meta-tags"

# Javascript
gem "uglifier", ">= 1.3.0"
gem "jbuilder", "~> 2.5"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"

# Presentation
gem "dc_ui", github: "leonid-io/dc-ui", branch: "master"
gem "slim-rails"
gem "semantic-ui-sass" # Still needed because we're using the breadcrumb helper
gem "cells"
gem "cells-rails"
gem "cells-slim"
gem "chartkick"
gem "simple_form"
gem "readingtime"
gem "webpacker", "~> 3.0"

# File Upload
gem "uploadcare-rails", "~> 1.1"
gem "fog-aws"

# Errors
gem "rollbar"

gem "heroku-deflater", group: :production
gem "rack-cors", require: "rack/cors"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end



group :development do
  gem "rb-readline"

  gem "better_errors"
  gem "binding_of_caller"

  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"

  # guard files
  gem "guard"
  gem "guard-rspec", require: false
  gem "guard-rubocop"
  gem "terminal-notifier-guard", "~> 1.6.1"

  gem "web-console", ">= 3.3.0"

  # CLI
  gem "thor"
  gem "tty-prompt"
end

group :test do
  # code quality
  gem "simplecov", require: false
  gem "codecov", require: false

  # rubocop
  gem "rubocop"
  gem "rubocop-rails_config"

  # browser testing
  gem "selenium-webdriver"
  gem "chromedriver-helper"
  gem "capybara", ">= 2.15", "< 4.0"

  # testing
  gem "rspec-rails"
  gem "rspec-cells"
  gem 'rspec_tap'
  gem "rails-controller-testing"
  gem "factory_bot_rails"
  gem "faker"
end

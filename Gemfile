# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.3.1"

# Backend
gem "ahoy_matey"
gem "analytics-ruby"
gem "blazer"
gem "bootsnap", ">= 1.1.0", require: false
gem "iso_country_codes"
gem "nexmo"
gem "rails", "~> 5.2.0"
gem "pg", ">= 0.18", "< 2.0"
gem "phonelib"
gem "puma", "~> 3.11"
gem "redis"
gem "redis-namespace"
gem "redis-rails"
gem "redis-rack-cache"
gem "rack-mini-profiler"
gem "chronic"
gem "config"
gem "erubis"
gem "friendly_id", "~> 5.1.0"
gem "groupdate"
gem "httparty"
gem "validate_url"
gem "wicked"

# Pagination
gem "kaminari"

# Active Record
gem "store_base_sti_class"

# Authentication
gem "devise"
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
gem "webpacker", "~> 3.0"
gem "slim-rails"
gem "semantic-ui-sass" # Still needed because we're using the breadcrumb helper
gem "cells"
gem "cells-rails"
gem "cells-slim"
gem "chartkick"
gem "simple_form"
gem "readingtime"

# File Upload
gem "uploadcare-rails"

# Errors
gem "rollbar"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "capybara", ">= 2.15", "< 4.0"
  gem "selenium-webdriver"
  gem "chromedriver-helper"
  gem "rubocop"
  gem "rubocop-rails"
  gem "rspec-rails"
  gem "rspec-cells"
  gem "factory_bot_rails"
  gem "faker"
end

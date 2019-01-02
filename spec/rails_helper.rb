# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment.rb", __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

require "spec_helper"
require "rspec/rails"

require "factory_bot_rails"
require "faker"
require "devise"
require "friendly_id"

ActiveRecord::Migration.maintain_test_schema!

# Ensuring site settings are loaded for the test
$site_setting_interface.update

RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers
  config.include Warden::Test::Helpers, type: :controller

  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

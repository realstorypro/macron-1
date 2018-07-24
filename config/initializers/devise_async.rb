# frozen_string_literal: true

Devise::Async.setup do |config|
  config.enabled = true
  if Rails.env.test?
    config.enabled = false
  else
    config.enabled = true
  end
end

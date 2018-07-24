# frozen_string_literal: true

if Rails.env.development?
  Sidekiq.configure_server do |config|
    config.redis = { url: "redis://localhost:6379" }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: "redis://localhost:6379" }
  end
end

if Rails.env.production?
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV["REDIS_URL"] }
  end

  Sidekiq.configure_server do |config|
    config.redis = { url: ENV["REDIS_URL"] }
  end
end

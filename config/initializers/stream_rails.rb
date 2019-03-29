require 'stream_rails'

StreamRails.configure do |config|
  config.api_key      = ENV["STREAM_API_KEY"]
  config.api_secret   = ENV["STREAM_API_SECRET"]
  config.timeout      = 30 
end

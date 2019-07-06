# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy
# For further information see the following documentation
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

Rails.application.config.content_security_policy do |policy|
  #   policy.default_src :self, :https
  #   policy.font_src    :self, :https, :data
  #   policy.img_src     :self, :https, :data
  #   policy.object_src  :none
  #   policy.script_src  :self, :https
  #   policy.style_src   :self, :https

  #   # Specify URI for violation reports
  #   # policy.report_uri "/csp-violation-report-endpoint"

  policy.connect_src :self, :https, "http://localhost:3035", "ws://localhost:3000", "ws://localhost:3035", "wss://faye.getstream.io" if Rails.env.development?

  if Rails.env.development?
    policy.script_src :self, :http, :https, "http://cdn.segment.com", "wss://faye.getstream.io", :unsafe_eval, :unsafe_inline
  else
    policy.script_src :self, :http, :https, "http://cdn.segment.com", "wss://faye.getstream.io", :unsafe_eval, :unsafe_inline
    policy.font_src   :self, :https, :data
  end
end

# If you are using UJS then enable automatic nonce generation
# Rails.application.config.content_security_policy_nonce_generator = -> request { SecureRandom.base64(16) }

# Report CSP violations to a specified URI
# For further information see the following documentation:
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy-Report-Only
# Rails.application.config.content_security_policy_report_only = true

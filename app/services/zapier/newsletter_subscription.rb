# frozen_string_literal: true

module Zapier
  class NewsletterSubscription < Zapier::Base
    def call_operation
      HTTParty.post(ss('integration.newsletter_webhook'), body: params)
    end

    def params
      {
        email: resource.email
      }
    end
  end
end

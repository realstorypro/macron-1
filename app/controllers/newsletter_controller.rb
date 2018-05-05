# frozen_string_literal: true

class NewsletterController < ApplicationController
  def subscribe
    subscriber = Subscriber.new(email: params[:email])
    if subscriber.valid?
      Zapier::NewsletterSubscription.new(subscriber).post_to_zapier
      return head 200
    end
    head 500
  end
end

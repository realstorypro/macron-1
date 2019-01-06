# frozen_string_literal: true

class NewsletterController < ApplicationController
  def subscribe
    subscriber = Subscriber.new(email: params[:email])
    if subscriber.valid?
      Zapier::NewsletterSubscription.new(subscriber).post_to_zapier
      record_subscription
      return head 200
    end
    head 500
  end

  def record_subscription
    track(
      user: current_user,
      event: "Subscription Created",
      props: {
        email: params[:email],
        location: "footer"
      }
    )
  end
end

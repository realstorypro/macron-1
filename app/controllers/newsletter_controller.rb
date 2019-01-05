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
    ahoy.track "Subscription Created"

    if user_signed_in?
      Analytics.track(
        user_id: current_user.id,
        event: "Subscription Created",
        properties: {
            username: current_user.username,
            email: current_user.email,
            location: "footer"
        }
      )
    else
      Analytics.track(
        anonymous_id: current_visit.visitor_token,
        event: "Subscription Created",
        properties: {
            email: params[:email],
            location: "footer"
        }
      )
    end
  end
end

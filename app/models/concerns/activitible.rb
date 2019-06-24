# frozen_string_literal: true

module Activitible
  extend ActiveSupport::Concern

  included do
    has_many :activities, as: :subject
    after_create :log_activity
    before_destroy :destroy_activity

    # logs the activity for the class
    def log_activity
      Activity.create(
        actor: self.user,
        subject: self,
        action: "created"
      )
    end

    def destroy_activity
      Activity.where(
        actor: self.user,
        subject: self
      ).first.destroy
    end
  end
end

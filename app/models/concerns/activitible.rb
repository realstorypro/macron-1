# frozen_string_literal: true

module Activitible
  extend ActiveSupport::Concern

  included do
    has_many :activities, as: :subjectable
    after_create :log_activity
    before_destroy :destroy_activity

    # logs the activity for the class
    def log_activity
      Activity.create(
        actable: self.user,
        subjectable: self,
        action: 'created'
      )
    end

    def destroy_activity
      Activity.where(
        actable: self.user,
        subjectable: self
      ).first.destroy
    end
  end
end

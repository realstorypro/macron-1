# frozen_string_literal: true

module Activitible
  extend ActiveSupport::Concern

  included do
    has_many :activities, as: :subject
    after_create :log_activity
    after_save :publishing_checks
    before_destroy :destroy_activity

    # only log activity if the class doesn't
    # respond to the publish date
    def log_activity
      create_activity unless self.respond_to?(:published_date)
    end

    def create_activity
      Activity.create(
        actor: self.user,
        subject: self,
        action: "created"
      )
    end

    def destroy_activity
      activities = Activity.where(
        actor: self.user,
        subject: self
      )
      activities.first.destroy if activities.count > 0
    end

    def publishing_checks
      return true unless self.respond_to?(:published_date)

      # destroy old activities if entry changed published date
      # or user id.
      if  self.saved_changes.include?("published_date") || self.saved_changes.include?("user_id")
        Activity.where( subject: self ).delete_all
      end

      # create a publishing record
      unless self.published_date.nil?
        create_activity
      end
    end
  end
end

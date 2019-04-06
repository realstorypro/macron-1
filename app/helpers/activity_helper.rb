# frozen_string_literal: true

module ActivityHelper
  # returns the verb of the trackable based on its type
  def activity_verb (activity)
    if activity.trackable_type == "Comment"
      "has left a comment on "
    elsif activity.trackable_type == "Article"
      "published a "
    elsif activity.trackable_type == "Video"
      "published a "
    elsif activity.trackable_type == "Podcast"
      "published a "
    elsif activity.trackable_type == "Discussion"
      "published a "
    elsif activity.trackable_type == "Event"
    end
  end
end

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

  # returns long date of the trackable in RFC882 Form
  def long_published_date(trackable)
    Time.new(trackable.published_date.year, trackable.published_date.month, trackable.published_date.day).to_formatted_s(:rfc822)
  end
end

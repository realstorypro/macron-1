# frozen_string_literal: true

module ActivityHelper
  # returns the verb of the trackable based on its type
  def activity_verb (activity)
    t("activity.#{activity.subject_type.downcase}.#{activity.action}")
  end
end

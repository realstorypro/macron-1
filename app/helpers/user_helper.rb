# frozen_string_literal: true

module UserHelper
  # renders profile avatar if one has been uploaded
  # todo: remove helper and utilize the avatar function on user model
  def avatar_thumbnail(user = current_user, resize = true)
    if user.profile.respond_to?(:avatar) && user.profile.avatar.nil? == false
      if resize
        user.profile.avatar.gsub("-/resize/600x600/", "-/resize/70x70/-/quality/lightest/")
      else
        user.profile.avatar
      end
    else
      "default-avatar.jpg"
    end
  end
end

# frozen_string_literal: true

module UserHelper
  # renders profile avatar if one has been uploaded
  # todo: remove helper and utilize the avatar function on user model
  def avatar_thumbnail(user = current_user)
    if user.profile.respond_to?(:avatar) && user.profile.avatar.nil? == false
      user.profile.avatar
    else
      "default-avatar.jpg"
    end
  end
end

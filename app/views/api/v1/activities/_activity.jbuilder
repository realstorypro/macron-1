# frozen_string_literal: true

json.verb activity_verb(activity)
json.created_at activity.created_at

json.owner do
  json.username activity.actable.username.capitalize
  json.avatar activity.actable.profile.avatar
  json.url member_path(activity.actable.id)
end

json.object do
  if activity.subjectable_type == "Comment"
    json.type activity.subjectable_type
    json.id activity.subjectable.commentable.id
    json.name activity.subjectable.commentable.name
    json.url entry_url(activity.subjectable.commentable)
    json.category activity.subjectable.commentable.category.name
    json.body strip_tags(activity.subjectable.body).truncate(200)
  #elsif activity.trackable_type == "Follow"
  #  json.type activity.trackable.follower_type
  #  json.id activity.trackable.followable.id
  #  json.name activity.trackable.followable.username
  #  json.url member_path(activity.trackable.followable)
  #elsif activity.trackable_type == "Like"
  #  #json.type activity.trackable.likeable_type
  #  json.id activity.trackable.likeable.id
  #  json.name activity.trackable.likeable.name
  #  json.url entry_url(activity.trackable.likeable)
  else
    json.type activity.subjectable_type
    json.id activity.subjectable.id
    json.name activity.subjectable.name
    json.url entry_url(activity.subjectable)
    json.category activity.subjectable.category.name
    json.card_image activity.subjectable.card_image
  end
end

# frozen_string_literal: true

json.type activity.trackable_type.downcase
json.verb activity_verb(activity)
json.created_at activity.created_at

json.owner do
  json.username activity.owner.username.capitalize
  json.avatar activity.owner.profile.avatar
  json.url member_path(activity.owner.id)
end

json.object do
  if activity.trackable_type == "Comment"
    json.type activity.trackable.commentable.type
    json.id activity.trackable.commentable.id
    json.name activity.trackable.commentable.name
    json.url entry_url(activity.trackable.commentable)
    json.category activity.trackable.commentable.category.name
    json.body strip_tags(activity.trackable.body).truncate(200)
  elsif activity.trackable_type == "Follow"
    json.type activity.trackable.follower_type
    json.id activity.trackable.followable.id
    json.name activity.trackable.followable.username
    json.url member_path(activity.trackable.followable)
  else
    json.type activity.trackable.type
    json.id activity.trackable.id
    json.name activity.trackable.name
    json.url entry_url(activity.trackable)
    json.category activity.trackable.category.name
    json.card_image activity.trackable.card_image
  end
end

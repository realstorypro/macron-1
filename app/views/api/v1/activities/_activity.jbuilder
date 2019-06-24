# frozen_string_literal: true

json.verb activity_verb(activity)
json.created_at activity.created_at

json.owner do
  json.username activity.actor.username.capitalize
  json.avatar activity.actor.profile.avatar
  json.url member_path(activity.actor.id)
end

json.object do
  if activity.subject_type == "Comment"
    json.type activity.subject_type
    json.id activity.subject.commentable.id
    json.name activity.subject.commentable.name
    json.url entry_url(activity.subject.commentable)
    json.category activity.subject.commentable.category.name
    json.body strip_tags(activity.subject.body).truncate(200)
  # elsif activity.trackable_type == "Follow"
  #  json.type activity.trackable.follower_type
  #  json.id activity.trackable.followable.id
  #  json.name activity.trackable.followable.username
  #  json.url member_path(activity.trackable.followable)
  # elsif activity.trackable_type == "Like"
  #  #json.type activity.trackable.likeable_type
  #  json.id activity.trackable.likeable.id
  #  json.name activity.trackable.likeable.name
  #  json.url entry_url(activity.trackable.likeable)
  else
    json.type activity.subject_type
    json.id activity.subject.id
    json.name activity.subject.name
    json.url entry_url(activity.subject)
    json.category activity.subject.category.name
    json.card_image activity.subject.card_image
  end
end

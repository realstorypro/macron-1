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
  else
    json.type activity.subject_type
    json.id activity.subject.id
    json.name activity.subject.name
    json.url entry_url(activity.subject)
    json.category activity.subject.category.name
  end
end

# frozen_string_literal: true

json.comments @comments do |comment|
  json.id comment.id
  json.body comment.body
  json.created_at comment.created_at

  if current_user.present? && (comment.user_id.eql?(current_user.id) || current_user.can_manage?(:comments))
    json.editable true
  else
    json.editable false
  end

  json.user do
    json.id comment.user.id
    json.username comment.user.username
    json.slug comment.user.slug
    json.created_at comment.user.created_at
    json.posts comment.user.comments_count
    json.title comment.user.profile.title
    json.avatar comment.user.profile.avatar
    json.location comment.user.profile.location
    json.age comment.user.profile.age
    json.signature comment.user.profile.signature
  end
end

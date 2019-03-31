# frozen_string_literal: true

# json.user_id = @activities[0]['actor']
json.result @activities
@activities.each do |activity|
  json.user do
    json.id = activity["actor"]["id"]
    json.username activity["actor"]["username"]
    json.slug activity["actor"]["slug"]
  end
  json.object do
    json.id activity["object"]["id"]
    json.name activity["object"]["name"]
  end
  #json.actor = activity["actor"]["id"]
end

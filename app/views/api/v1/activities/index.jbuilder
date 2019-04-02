json.activities @activities.each_with_index  do |activity, index|
    json.time = activity["time"]
    json.verb = activity["verb"]

    json.user do
      json.id = activity["actor"].id
      json.username activity["actor"].username
      json.slug activity["actor"].slug
      json.avatar activity["actor"].profile.avatar
    end

    json.object do
      json.id activity["object"].id
      json.name activity["object"].name
      json.slug activity["object"].slug
      json.image activity["object"].card_image
      json.category activity["object"].category
    end
end

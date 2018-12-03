json.title ss("general.name")
json.description ss("general.description")
json.link root_url
json.updated Time.new(@age.year, @age.month, @age.day).to_formatted_s(:rfc822)


json.entries @entries.each do |entry|
  json.title entry.name
  json.description entry.description
  json.type entry.type
  json.category entry.category.name
  json.color entry.category.color.name
  json.published Time.new(entry.published_date.year, entry.published_date.month, entry.published_date.day).to_formatted_s(:rfc822)
end


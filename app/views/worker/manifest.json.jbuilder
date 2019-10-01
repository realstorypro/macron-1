# frozen_string_literal: true

json.name ss("general.name")
json.short_name ss("general.name")
json.lang "en-US"
json.start_url "/"
json.display "standalone"

# TODO: pull from theme settings
json.theme_color "#000"
json.background_color "#000"

# TODO: pull from an uploaded image
icons = [
  { src: image_url("icon.png"), sizes: "512x512" },
]

json.icons do
  json.merge! icons
end

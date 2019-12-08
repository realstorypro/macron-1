# frozen_string_literal: true

json.name ss("general.name")
json.short_name ss("general.name")
json.lang "en-US"
json.start_url "/"
json.display "standalone"

# TODO: pull from theme settings
json.theme_color "#000"
json.background_color "#000"

if ENV["BRANDED"] == "true"
  icons = [
    { src: image_url("icon.png"), sizes: "512x512" },
  ]
else
  icons = [
    { src: ss("theme.branding.app_icon"), sizes: "512x512" },
  ]
end

json.icons do
  json.merge! icons
end

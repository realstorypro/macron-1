# frozen_string_literal: true

# Load Core Config
Settings.add_source!(Rails.root.join("core").join("defaults.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("auth.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("menu.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("colors.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("pages.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("tests.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("components.yml").to_s)

Settings.add_source!(Rails.root.join("core").join("views/defaults.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("views/profile.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("views/users.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("views/articles.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("views/discussions.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("views/advertisements.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("views/tags.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("views/categories.yml").to_s)

Settings.add_source!(Rails.root.join("core").join("views/settings/general.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("views/settings/branding.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("views/settings/theme.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("views/settings/contact.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("views/settings/integration.yml").to_s)

Settings.reload!

# frozen_string_literal: true

# Load Core Config
Settings.add_source!(Rails.root.join("core").join("defaults.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("auth.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("menu.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("colors.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("pages.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("tests.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("components.yml").to_s)
Settings.add_source!(Rails.root.join("core").join("views.yml").to_s)

Settings.reload!

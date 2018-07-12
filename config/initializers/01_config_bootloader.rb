# frozen_string_literal: true

# Load Implementation Config
Settings.add_source!(Rails.root.join("implementations").join("common/default.yml").to_s)
Settings.add_source!(Rails.root.join("implementations").join("gravity.yml").to_s)
Settings.reload!

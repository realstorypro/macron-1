# frozen_string_literal: true

require "test_helper"
require "generators/rails/theme_settings/theme_settings_generator"

class Rails::ThemeSettingsGeneratorTest < Rails::Generators::TestCase
  tests Rails::ThemeSettingsGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end

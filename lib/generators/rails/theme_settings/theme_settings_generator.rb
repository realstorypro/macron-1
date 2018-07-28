class Rails::ThemeSettingsGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def copy_theme_settings_file
    copy_file "view.yml", "core/views/settings/theme/#{file_name}.yml"

  end
end

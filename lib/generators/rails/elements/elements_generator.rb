# rubocop:disable FrozenStringLiteralComment
# rubocop:disable LineLength

class Rails::ElementsGenerator < Rails::Generators::NamedBase
  require "yaml"
  source_root File.expand_path("templates", __dir__)

  def copy_settings_file
    # copy view files
    # copy model files
    copy_file "model.rb", "app/models/site_settings/#{file_name}.rb"
    gsub_file "app/models/site_settings/#{file_name}.rb", "<~~ class_name ~~>", class_name
  end
end

# rubocop:enable FrozenStringLiteralComment
# rubocop:enable LineLength

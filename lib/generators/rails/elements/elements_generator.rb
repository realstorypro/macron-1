# rubocop:disable FrozenStringLiteralComment
# rubocop:disable LineLength

class Rails::ElementsGenerator < Rails::Generators::NamedBase
  require "yaml"
  source_root File.expand_path("templates", __dir__)

  def copy_settings_file
    # copy model files
    copy_file "model.rb", "app/models/elements/#{file_name}.rb"
    gsub_file "app/models/elements/#{file_name}.rb", "<~~ class_name ~~>", class_name

    # copy the component file
    copy_file "element_component.yml", "core/elements/#{file_name}.yml"
    gsub_file "core/elements/#{file_name}.yml", "<~~ lowercase_name ~~>", class_name.downcase
    gsub_file "core/elements/#{file_name}.yml", "<~~ class_name ~~>", class_name

  end
end

# rubocop:enable FrozenStringLiteralComment
# rubocop:enable LineLength

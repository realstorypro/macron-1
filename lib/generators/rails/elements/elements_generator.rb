# rubocop:disable FrozenStringLiteralComment
# rubocop:disable LineLength

class Rails::ElementsGenerator < Rails::Generators::NamedBase
  require "yaml"
  source_root File.expand_path("templates", __dir__)

  class_option :desc, type: :string, default: "Element Description"

  def copy_element_file
    prompt = TTY::Prompt.new

    @description= options["desc"]

    # copy model files
    copy_file "model.rb", "app/models/elements/#{file_name}.rb"
    gsub_file "app/models/elements/#{file_name}.rb", "<~~ class_name ~~>", class_name

    # copy the component file
    copy_file "element_component.yml", "core/elements/#{file_name}.yml"
    gsub_file "core/elements/#{file_name}.yml", "<~~ lowercase_name ~~>", class_name.downcase
    gsub_file "core/elements/#{file_name}.yml", "<~~ class_name ~~>", class_name
    gsub_file "core/elements/#{file_name}.yml", "<~~ element_description ~~>", @description

    # copy the view file
    copy_file "element_view.yml", "core/views/elements/#{file_name}.yml"
    gsub_file "core/views/elements/#{file_name}.yml", "<~~ lowercase_name ~~>", class_name.downcase

    # copy cell files
    copy_file "cell.rb", "app/cells/elements/#{file_name}_cell.rb"
    gsub_file "app/cells/elements/#{file_name}_cell.rb", "<~~ class_name ~~>", class_name

    # copy the cell show files
    directory 'cell_view', "app/cells/elements/#{file_name}"
    gsub_file "app/cells/elements/#{file_name}/show.slim", "<~~ class_name ~~>", class_name

    prompt.ok "All Files Copied"
  end
end

# rubocop:enable FrozenStringLiteralComment
# rubocop:enable LineLength

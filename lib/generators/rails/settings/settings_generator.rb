# rubocop:disable FrozenStringLiteralComment
# rubocop:disable LineLength

class Rails::SettingsGenerator < Rails::Generators::NamedBase
  require "yaml"
  source_root File.expand_path("templates", __dir__)

  def copy_settings_file
    # copy routing files
    route = 'resource :<~~ singular_name ~~>, controller: "<~~ singular_name ~~>", component: "site_settings_<~~ singular_name ~~>"'
    route.gsub!("<~~ singular_name ~~>", plural_name.singularize)
    inject_into_file "config/routes.rb", optimize_indentation(route, 8), after: "root to: \"settings#all\"\n"

    # copy view files
    copy_file "view.yml", "core/views/settings/#{file_name}.yml"
    gsub_file "core/views/settings/#{file_name}.yml", "<~~ class_name ~~>", plural_name.singularize

    # copy model files
    copy_file "model.rb", "app/models/site_settings/#{file_name}.rb"
    gsub_file "app/models/site_settings/#{file_name}.rb", "<~~ class_name ~~>", class_name

    # copy controller files
    copy_file "controller.rb",
              "app/controllers/admin/site_settings/#{file_name}_controller.rb"

    gsub_file "app/controllers/admin/site_settings/#{file_name}_controller.rb",
              "<~~ class_name ~~>", class_name

    gsub_file "app/controllers/admin/site_settings/#{file_name}_controller.rb",
              "<~~ lowercase_name ~~>", file_name
  end
end

# rubocop:enable FrozenStringLiteralComment
# rubocop:enable LineLength

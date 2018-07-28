class Rails::ThemeSettingsGenerator < Rails::Generators::NamedBase
  require 'yaml'
  source_root File.expand_path('templates', __dir__)

  def copy_theme_settings_file
    # copy routing files
    route = 'resource :<~~ singular_name ~~>, controller: "theme_<~~ singular_name ~~>", component: "site_settings_theme_<~~ singular_name ~~>"'
    route.gsub!('<~~ singular_name ~~>', plural_name.singularize)
    inject_into_file 'config/routes.rb', optimize_indentation(route, 8), after: "root to: \"theme#all\"\n"

    # copy view files
    copy_file "view.yml", "core/views/settings/theme/#{file_name}.yml"
    gsub_file "core/views/settings/theme/#{file_name}.yml", '<~~ class_name ~~>', plural_name.singularize

    # copy model files
    copy_file "model.rb", "app/models/site_settings/theme/#{file_name}.rb"
    gsub_file "app/models/site_settings/theme/#{file_name}.rb", '<~~ class_name ~~>', class_name

    # copy controller files
    copy_file "controller.rb", "app/controllers/admin/site_settings/theme/theme_#{file_name}_controller.rb"
    gsub_file "app/controllers/admin/site_settings/theme/theme_#{file_name}_controller.rb", '<~~ class_name ~~>', class_name
    gsub_file "app/controllers/admin/site_settings/theme/theme_#{file_name}_controller.rb", '<~~ lowercase_name ~~>', file_name

    # load auth yaml file
    auth_file = YAML::load_file("core/auth.yml")
    admin_permissions = auth_file['auth']['permissions']['admin']
    byebug

  end
end

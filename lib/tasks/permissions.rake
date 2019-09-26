# frozen_string_literal: true

namespace :permissions do
  desc "Enables permission for a user"
  task enable: :environment do
    prompt = TTY::Prompt.new

    # loads the actual components
    components = Settings.components.reject { |component| !component[1].enabled }

    # regular components
    regular_components = components.reject do |component|
      component[0].to_s.include?("site_settings") || component[0].to_s.include?("elements")
    end

    # site settings
    site_settings = components.select { |component| component[0].to_s.include? "site_settings" }

    # elements
    elements = components.select { |component| component[0].to_s.include? "elements" }

    component_array = prompt.select("What are you modifying permissions for?") do |menu|
      menu.choice "Components", { array: regular_components }
      menu.choice "Elements", { array: elements }
      menu.choice "Site Settings", { array: site_settings }
    end

    component_names = component_array[:array].map { |component| component[0] }

    # loads in the auth file
    auth = YAML.load_file(Rails.root.join("core").join("auth.yml"))

    # loads the actual auth
    auth = auth["auth"]

    # loads in the abilities
    abilities = auth["abilities"]

    # get the permissions path
    permissions_path = Rails.root.join("core").join("permissions").to_s

    # get all of the files inside a directory
    permissions = Dir.entries(permissions_path).select { |f| !File.directory? f }

    # get only the names of the files
    role_names = permissions.map { |f| f.split(".")[0] }

    selected_role = prompt.select "Which role?", role_names, per_page: 20, filter: true
    selected_component = prompt.select "Which component?", component_names, per_page: 20, filter: true
    selected_ability = prompt.multi_select "Which ability?", abilities, per_page: 20, filter: true

    # breaks out if no ability has been selected
    break puts "no ability selected" if selected_ability.blank?

    permission_file = YAML.load_file(Rails.root.join("core").join("permissions").join("#{selected_role}.yml"))
    permission_file["selected_component"]

    selected_ability.each do |ability|
      if permission_file["auth"]["permissions"][selected_role][selected_component].nil?
        permission_file["auth"]["permissions"][selected_role][selected_component] = {}
      end
      permission_file["auth"]["permissions"][selected_role][selected_component][ability] = nil
    end

    File.open(Rails.root.join("core").join("permissions").join("#{selected_role}.yml"), "w") do |f|
      f.write permission_file.to_yaml
    end
  end

  desc "Disable disables permission for a user"
  task disable: :environment do
  end
end

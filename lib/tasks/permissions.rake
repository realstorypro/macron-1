# frozen_string_literal: true
#
namespace :permissions do
  desc "Enables permission for a user"
  task enable: :environment do
    prompt = TTY::Prompt.new

    # loads in the component file
    components = YAML.load_file(Rails.root.join("core").join("components.yml"))

    # loads the actual components
    components = components["components"]
    component_names = components.map {|component| component[0]}

    # loads in the auth file
    auth = YAML.load_file(Rails.root.join("core").join("auth.yml"))

    # loads the actual auth
    auth = auth["auth"]

    # loads in the abilities
    abilities = auth["abilities"]

    # get the permissions path
    permissions_path = Rails.root.join("core").join("permissions").to_s

    # get all of the files inside a directory
    permissions = Dir.entries(permissions_path).select {|f| !File.directory? f}

    # get only the names of the files
    role_names = permissions.map {|f| f.split(".")[0]}

    selected_role = prompt.select "Which role?", role_names, per_page: 20, filter: true
    selected_component = prompt.select "Which component?", component_names, per_page: 20, filter: true
    selected_ability = prompt.multi_select "Which ability?", abilities, per_page: 20, filter: true

    # breaks out if no ability ahs been selected
    break puts "no ability selected" if selected_ability.blank?

    permission_file = YAML.load_file(Rails.root.join("core").join("permissions").join("#{selected_role}.yml"))
    permission_file["selected_component"]
    selected_ability.each do |ability|
      if permission_file["auth"]["permissions"][selected_role][selected_component].nil?
        permission_file["auth"]["permissions"][selected_role][selected_component] = {}
      end
      permission_file["auth"]["permissions"][selected_role][selected_component][ability] = nil
    end

    File.open(Rails.root.join("core").join("permissions").join("#{selected_role}.yml"), "w") {|f| f.write permission_file.to_yaml }
  end

  desc "Disable disables permission for a user"
  task disable: :environment do
    prompt = TTY::Prompt.new
  end
end

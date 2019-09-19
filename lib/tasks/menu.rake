# frozen_string_literal: true

namespace :menu do
  desc "Importing components into menu files"
  task setup: :environment do
    prompt = TTY::Prompt.new

    # load up components and remove the non-disableable components
    components = Settings.components.reject

    # components
    # todo: implement in the future
    regular_components = components.reject { |component| component[0].to_s.include?("site_settings") || component[0].to_s.include?("elements") }
    regular_components = regular_components.select { |component| component[1].enabled }

    # site settings
    # todo: implement in the future
    site_settings = components.select { |component| component[0].to_s.include? "site_settings" }
    site_settings = site_settings.select { |component| component[1].enabled }

    # elements
    elements = components.select { |component| component[0].to_s.include? "elements" }

    modification = prompt.select("What menu would you like to modify?") do |menu|
      menu.choice "Elements", { menu: "core/menus/elements.yml", components: elements, namespace: 'elements'}
    end

    menu_file = YAML.load_file(Rails.root.join(modification[:menu]))

    component_names = modification[:components].map { |component| component[1] }
    component_names = component_names.reject do |component|
      component.klass == "Elements"
    end

    # remove already active componenets
    menu_file["menu"][modification[:namespace]].each do |menu_item|
      component_names = component_names.reject do |component|
        component.klass.downcase.gsub("::",'_') == menu_item["section"][0]["component"]
      end
    end

    selected_component = prompt.select"What component are we adding?", component_names

    icon = prompt.ask('What is the name of the icon?')

    menu_file["menu"][modification[:namespace]][0]["section"] <<
        {
            "name" => selected_component.name,
            "hint" => selected_component.description,
            "component" => selected_component.klass.downcase.gsub("::",'_' ),
            "icon" => icon,
            "enabled" => true
        }

    File.open(Rails.root.join(modification[:menu]), "w") do |f|
      f.write menu_file.to_yaml
    end

  end
end

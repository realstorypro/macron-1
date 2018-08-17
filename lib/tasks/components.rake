# frozen_string_literal: true

namespace :components do
  desc "Setting up components"
  task setup: :environment do

    # load up components and remove the non-disableable components
    components = Settings.components.reject do |component|
      reject_list = %w(dummy admin comments profiles members users dashboard categories tags support)
      reject_list.include?(component[0].to_s)
    end

    # remove all of the site settings
    components = components.reject do |component|
      component[0].to_s.include? "site_settings"
    end

    components.each do |component|
      Component.find_or_create_by name: component[0].to_s, enabled: component[1].enabled
    end
  end

  desc "Delete all components"
  task delete_all: :environment do
    Component.delete_all
  end
end

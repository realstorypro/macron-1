# frozen_string_literal: true

namespace :components do
  desc "Importing components into the database."
  task setup: :environment do
    # load up components and remove the non-disableable components
    components = Settings.components.reject do |component|
      reject_list = %w(admin comments profiles members users dashboard categories tags support)
      reject_list.include?(component[0].to_s) && component[1].enabled
    end

    # remove all of the site settings
    components = components.reject { |component| component[0].to_s.include? "site_settings" }

    # select all enabled components
    components = components.select { |component| component[1].enabled }

    components.each do |component|
      SiteSettings::Component.find_or_create_by name: component[0].to_s, enabled: component[1].enabled
    end
  end

  desc "Delete all components"
  task delete_all: :environment do
    SiteSettings::Component.delete_all
  end
end

# frozen_string_literal: true

module Autoloadable
  extend ActiveSupport::Concern

  included do
    # returns the lowercase version of the class
    class_name = self.name.downcase

    # changing namespaces into the "_" format
    class_name = class_name.gsub("::", "_")

    # chance the namespace from sitesettings to site_settings
    # todo get rid of this to keep things consistent
    if class_name.include?("sitesettings")
      class_name = class_name.gsub("sitesettings", "site_settings")
    end

    # for entries we want to clean up the class for entries since
    # they are just regular components with a namespace
    # if class_name.include?("entries")
    #   class_name.gsub!("entries::", "")
    # end

    setting = SettingInterface.new(Settings)
    data_type = DataType.new()

    # pull in the fields
    fields = setting.fetch_setting("views.#{class_name}.new")

    # pull in configuration
    config = setting.fetch_setting("views.#{class_name}.config")

    # removing non payloadable fields
    rejected_types = %w(header association dropdown).freeze

    rejected_names = config&.rejected_field_names.split(" ")

    fields = fields.reject { |field| rejected_types.include?(field[1].type) }
    fields = fields.reject { |field| rejected_names.include?(field[0].to_s) }

    # adding payload
    fields.each do |field|
      content_attr field[0], data_type.which?(field[1].type)
      validates_presence_of field[0], on: :update if field[1].required
    end

    # setting defaults
    if config&.set_defaults
      instance = self.first_or_create!

      fields.each do |field|
        if instance.payload.nil? || !instance.payload.key?(field[0].to_s)
          instance.send("#{field[0]}=", field[1].default)
        end
      end

      instance.save
    end
  end
end

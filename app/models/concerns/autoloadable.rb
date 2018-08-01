# frozen_string_literal: true

module Autoloadable
  extend ActiveSupport::Concern

  included do
    # the views are plural
    class_name = self.name.downcase.pluralize

    # except for site settings
    if class_name.include?('sitesettings')
      class_name = self.name.downcase.singularize
      class_name = class_name.gsub('sitesettings', 'site_settings')
      class_name = class_name.gsub('::', '_')
    end

    setting = SettingInterface.new(Settings)
    data_type = DataType.new()

    # pull in the fields
    fields = setting.fetch_setting("views.#{class_name}.new")

    # removing non payloadable fields
    rejected_types = %w(header association dropdown).freeze

    rejected_names = %w(name slug published_date).freeze
    fields = fields.reject { |field| rejected_types.include?(field[1].type) }
    fields = fields.reject { |field| rejected_names.include?(field[0].to_s) }

    # adding payload
    fields.each do |field|
      content_attr field[0], data_type.which?(field[1].type)
      validates_presence_of field[0] if field[1].required
    end
  end
end

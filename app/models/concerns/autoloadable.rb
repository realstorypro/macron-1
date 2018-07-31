# frozen_string_literal: true

module Autoloadable
  extend ActiveSupport::Concern

  included do
    class_name = self.name.downcase.pluralize
    setting = SettingInterface.new(Settings)
    data_type = DataType.new()

    # pull in the fields
    fields = setting.fetch_setting("views.#{class_name}.new")

    # removing non payloadable fields
    # by type
    fields = fields.reject{|field| field[1].type == 'header'}
    fields = fields.reject{|field| field[1].type == 'association'}
    fields = fields.reject{|field| field[1].type == 'dropdown'}
    # by name
    fields = fields.reject{|field| field[0].to_s == 'name'}
    fields = fields.reject{|field| field[0].to_s == 'slug'}
    fields = fields.reject{|field| field[0].to_s == 'published_date'}

    # massive switch statement mapping the fields to field types
    # refer to admin_base_cell.rb for the reverse map

    fields.each do |field|
      content_attr field[0], data_type.which?(field[1].type)
    end

  end
end

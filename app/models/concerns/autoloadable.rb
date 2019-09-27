# frozen_string_literal: true

module Autoloadable
  extend ActiveSupport::Concern

  included do
    component = Component.new(klass: self)
    config = component.config
    fields = component.view("new")

    data_type = DataType.new()

    # removing non payloadable fields
    rejected_types = %w(header association dropdown).freeze

    # loading non payloadable fields from the config
    rejected_names = config&.rejected_field_names.split(" ")

    # removing both filed types and field names from the fields array
    fields = fields.reject { |field| rejected_types.include?(field[1].type) }
    fields = fields.reject { |field| rejected_names.include?(field[0].to_s) }

    # adding fields and validations to the model utilizing Payloadble concern
    # The validations added on update. This allows for items such as elements
    # to be created without any of the required fields filled out.
    fields.each do |field|
      content_attr field[0], data_type.which?(field[1].type)
      validates_presence_of field[0], on: :update if field[1].required
    end

    # Setting defaults for new keys. This is useful for things like Site Settings
    # It allows us to add new keys, and have the defaults be automatically set
    # Every time the model is reloaded.
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

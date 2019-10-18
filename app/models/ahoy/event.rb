# frozen_string_literal: true

# rubocop:disable Style/ClassAndModuleChildren
class Ahoy::Event < ApplicationRecord
  include Ahoy::QueryMethods

  self.table_name = "ahoy_events"

  belongs_to :visit
  belongs_to :user, optional: true
end
# rubocop:enable Style/ClassAndModuleChildren

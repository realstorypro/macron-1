# frozen_string_literal: true

# rubocop:disable Style/ClassAndModuleChildren
class Ahoy::Visit < ApplicationRecord
  self.table_name = "ahoy_visits"

  has_many :events, class_name: "Ahoy::Event"
  belongs_to :user, optional: true
end
# rubocop:enable Style/ClassAndModuleChildren

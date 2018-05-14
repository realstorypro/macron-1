# frozen_string_literal: true

require "friendly_id"

module Slugged
  extend ActiveSupport::Concern

  included do
    validates :slug, presence: true
    extend FriendlyId
    friendly_id :name, use: :slugged

    def should_generate_new_friendly_id?
      name_changed?
    end
  end
end

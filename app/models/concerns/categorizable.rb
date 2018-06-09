# frozen_string_literal: true

module Categorizable
  extend ActiveSupport::Concern

  included do
    belongs_to :category, optional: true
  end
end

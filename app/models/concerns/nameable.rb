# frozen_string_literal: true

module Nameable
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true
  end
end

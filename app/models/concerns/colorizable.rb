# frozen_string_literal: true

module Colorizable
  extend ActiveSupport::Concern

  included do
    belongs_to :color
  end
end

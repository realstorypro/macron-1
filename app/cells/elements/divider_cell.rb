# frozen_string_literal: true

module Elements
  class DividerCell < BaseElementCell
    def is_hidden?
      return true if !model.hidden.blank? && model.hidden == "true"
      false
    end
  end
end

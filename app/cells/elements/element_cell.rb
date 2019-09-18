# frozen_string_literal: true

module Elements
  class ElementCell < Cell::ViewModel
    include ::Cell::Builder
    builds do |model, options|
      if model.is_a?(Elements::Heading)
        Elements::HeadingCell
      end
    end

  end
end

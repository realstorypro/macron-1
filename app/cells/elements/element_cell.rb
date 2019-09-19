# frozen_string_literal: true

module Elements
  class ElementCell < Cell::ViewModel
    include ::Cell::Builder
    builds do |model, options|
      cell_class_name = model.class.to_s+"Cell"
      cell_class_name.classify.constantize
    end
  end
end

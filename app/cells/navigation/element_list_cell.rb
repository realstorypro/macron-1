# frozen_string_literal: true

module Navigation
  class ElementListCell < NavigationCell
    def link_path(path)
      url_helpers.add_element_admin_elements_path(parent_id: request.filtered_parameters["parent_id"],
                                                  parent_component: request.filtered_parameters["parent_component"],
                                                  element: path)
    end
  end
end

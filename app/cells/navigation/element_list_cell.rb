# frozen_string_literal: true

module Navigation
  class ElementListCell < NavigationCell
    def link_path(path)
      url_helpers.add_element_admin_page_path(id: request.filtered_parameters["id"], element: path)
    end
  end
end

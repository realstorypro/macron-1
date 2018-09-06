# frozen_string_literal: true

module Navigation
  class ElementListCell < NavigationCell
    def link_path(path)
      url_helpers.add_element_admin_elements_path(parent_id: request.filtered_parameters["parent_id"],
                                                  parent_component: request.filtered_parameters["parent_component"],
                                                  area: request.filtered_parameters["area"],
                                                  element: path)
    end

    private

      # checks if the menu item should be shown
      def show_item?(menu_item)
        # short circuits rendering unless the menu is enabled
        return false unless menu_item[:enabled]

        # hide advanced menu items unless user is in advanced mode
        return false if menu_item[:advanced] && !current_user.advanced

        # hide restricted areas
        restricted_areas = settings("components.#{menu_item["component"]}.restricted.areas")
        if restricted_areas
          return false unless restricted_areas.any? { |area| area == request.filtered_parameters["area"] }
        end

        return true if menu_item[:component] && options[:policy].index?(menu_item[:component])
        return true if menu_item[:component].nil?
        false
      end
  end
end

# frozen_string_literal: true

module Navigation
  class ElementListCell < NavigationCell
    def link_path(path)
      "add/" + path
    end
  end
end

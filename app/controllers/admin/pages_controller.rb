# frozen_string_literal: true

require_dependency "application_controller"

module Admin
  class PagesController < CrudController

    # picks an element
    def add_element
      render :add_element, layout: false
    end

    def add
      element = s("components.#{params[:element]}.klass").classify.constantize.create
      page = Page.find_by_id(params[:id])
      PageElement.create(page: page, element: element)
    end
  end
end

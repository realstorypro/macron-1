# frozen_string_literal: true

require_dependency "application_controller"

module Admin
  class PagesController < CrudController
    # picks an element
    def pick_element
      render :pick_element, layout: false
    end

    # adds an element
    def add
      element = s("components.#{params[:element]}.klass").classify.constantize.create
      page = Page.find_by_id(params[:id])
      page.elements << element
      redirect_back(fallback_location: admin_root_path)
    end

    # removes an element
    def remove
      Element.find_by_id(params[:element_id]).destroy
      redirect_back(fallback_location: admin_root_path)
    end

    # orders the elements
    def reorder
      params[:order].each_with_index do |page_element, index|
        PageElement.where(element_id: page_element).update_all(position: index + 1)
      end
      head :ok
    end
  end
end

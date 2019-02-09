# frozen_string_literal: true

require_dependency "application_controller"

module Admin
  class ElementsController < CrudController
    before_action :set_component, except: %i[pick_element add remove reorder]
    skip_before_action :set_breadcrumb

    def pick_element
      # TODO this may be unnecessary. Remove once tested.
      # parent = parent_class.find(params[:parent_id])
      render :pick_element, layout: false
    end

    def add
      parent = parent_class.find(params[:parent_id])

      # Create new area for the parent if one does not exist
      if parent.areas.count == 0 || parent.areas.any? { |area| area.type.include?(params[:area].capitalize) } == false
        parent.areas << "Areas::#{params[:area].capitalize}".classify.constantize.create
      end

      # Pick the right area
      area = parent.areas.select { |area_item| area_item.type.include?(params[:area].capitalize) }.last


      element = s("components.#{params[:element]}.klass").classify.constantize.create
      area.elements << element
      redirect_back(fallback_location: admin_root_path)
    end

    def destroy
      Element.find_by_id(params[:id]).destroy
      redirect_back(fallback_location: admin_root_path)
    end

    def reorder
      params[:order].each_with_index do |element, index|
        Element.where(id: element).update_all(position: index + 1)
      end
      head :ok
    end

    def set_component
      element = Element.find(params[:id])
      params[:component] = element.type.gsub("::", "_").downcase
    end

    def entry_params
      allowed_attrs = set_allowed_attrs
      component = settings("components.#{params[:component]}.klass").downcase
      component = component.gsub("::", "_")
      params.require(component).permit(*allowed_attrs)
    end

    private
      def parent_class
        settings("components.#{params[:parent_component]}.klass").classify.constantize
      end
  end
end

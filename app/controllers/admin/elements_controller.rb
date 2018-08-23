# frozen_string_literal: true

require_dependency "application_controller"

module Admin
  class ElementsController < CrudController
    before_action :set_component
    skip_before_action :set_breadcrumb

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
  end
end

# frozen_string_literal: true

require_dependency "application_controller"

module Admin::SiteSettings
  class ComponentsController < ApplicationController
    include AdminAccess
    layout "layouts/admin"

    before_action :set_breadcrumb

    private
      def set_breadcrumb
        semantic_breadcrumb "Settings", admin_settings_root_path
        semantic_breadcrumb "Components", ""
      end
  end
end

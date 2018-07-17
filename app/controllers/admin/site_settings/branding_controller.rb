# frozen_string_literal: true

require_dependency "application_controller"

module Admin::SiteSettings
  class BrandingController < SharedSettingsController
    before_action :set_breadcrumb

    def show
      add_to_actions(
        text: "Edit",
        class: "primary",
        icon: "edit",
        url: edit_admin_settings_branding_path,
        permission: policy(@entry).edit?,
        data: { widget: "crud", action: "edit" }
      )

      render "admin/crud/show"
    end

    private

      def load_entry
        @entry = SiteSettings::Branding.instance
      end

      def entry_params
        allowed_attrs = set_allowed_attrs
        params.require(:site_settings_branding).permit(*allowed_attrs)
      end

      def set_breadcrumb
        semantic_breadcrumb "Settings", admin_settings_root_path
        semantic_breadcrumb "Branding", admin_settings_branding_path
      end
  end
end

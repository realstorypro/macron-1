# frozen_string_literal: true

require_dependency "application_controller"

module Admin::SiteSettings
  class BrandingController < MetaController
    include AdminAccess
    layout "layouts/admin"

    before_action :set_breadcrumb

    def show
      if current_user.help
        add_to_actions(
            text: "Hide Help",
            class: "",
            icon: "question circle",
            url: disable_help_admin_user_path(current_user.id),
            permission: policy(current_user).disable_help?
        )
      else
        add_to_actions(
            text: "Show Help",
            class: "",
            icon: "question circle",
            url: enable_help_admin_user_path(current_user.id),
            permission: policy(current_user).enable_help?
        )
      end

      add_to_actions(
        text: "Edit",
        class: "primary",
        icon: "edit",
        url: edit_admin_settings_branding_path,
        permission: policy(@entry).edit?,
        data: { widget: "crud", action: "edit" }
      )

      render 'admin/crud/show_with_description'
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

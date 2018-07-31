# frozen_string_literal: true

require_dependency "application_controller"

module Admin::SiteSettings::Theme
  class ThemeGlobalController < ThemeController
    before_action :set_breadcrumb

    def show
      add_to_actions(
        text: "Edit",
        class: "primary",
        icon: "edit",
        url: edit_admin_settings_theme_global_path,
        permission: policy(@entry).edit?,
        data: { widget: "crud", action: "edit" }
      )

      render "admin/crud/show"
    end

    private

      def load_entry
        @entry = SiteSettings::Theme::Global.instance
      end

      def entry_params
        allowed_attrs = set_allowed_attrs
        params.require(:site_settings_theme_global).permit(*allowed_attrs)
      end

      def set_breadcrumb
        semantic_breadcrumb "Settings", admin_settings_root_path
        semantic_breadcrumb "Theme", admin_settings_theme_root_path
        semantic_breadcrumb "Global", ""
      end
  end
end

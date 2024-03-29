# frozen_string_literal: true

require_dependency "application_controller"

module Admin::SiteSettings::Theme
  class ThemeController < Admin::SiteSettings::SharedSettingsController
    before_action :set_breadcrumb

    def all
      unless current_user.help
        add_to_actions(
          text: "Help",
          class: "",
          icon: "question circle",
          url: enable_help_admin_user_path(current_user.id),
          permission: policy(current_user).enable_help?,
          data: { widget: "clicker", action: "click" }
        )
      end
    end

    private
      def set_breadcrumb
        semantic_breadcrumb "Settings", admin_settings_root_path
        semantic_breadcrumb "Theme", admin_settings_theme_root_path
      end
  end
end

# frozen_string_literal: true

require_dependency "application_controller"

module Admin::SiteSettings::Theme
  class ThemeDiscussionController < ThemeController
    before_action :set_breadcrumb

    def show
      super
      add_to_actions(
        text: "Edit",
        class: "primary",
        icon: "edit",
        url: edit_admin_settings_theme_discussion_path,
        permission: policy(@entry).edit?,
        data: { widget: "crud", action: "edit" }
      )

      render "admin/crud/show"
    end

    private
      def load_entry
        @entry = SiteSettings::Theme::Discussion.instance
      end

      def set_breadcrumb
        semantic_breadcrumb "Settings", admin_settings_root_path
        semantic_breadcrumb "Theme", admin_settings_theme_root_path
        semantic_breadcrumb "Discussions", ""
      end
  end
end

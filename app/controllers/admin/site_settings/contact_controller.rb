# frozen_string_literal: true

require_dependency "application_controller"

module Admin::SiteSettings
  class ContactController < SharedSettingsController
    before_action :set_breadcrumb

    def show
      super
      add_to_actions(
        text: "Edit",
        class: "primary",
        icon: "edit",
        url: edit_admin_settings_contact_path,
        permission: policy(@entry).edit?,
        data: { widget: "crud", action: "edit" }
      )

      render "admin/crud/show"
    end

    private
      def load_entry
        @entry = SiteSettings::Contact.instance
      end

      def set_breadcrumb
        semantic_breadcrumb "Settings", admin_settings_root_path
        semantic_breadcrumb "Contact", admin_settings_contact_path
      end
  end
end

# frozen_string_literal: true

require_dependency "application_controller"

module Admin::SiteSettings
  class <~~ class_name ~~>Controller < SharedSettingsController
    before_action :set_breadcrumb

    def show
      add_to_actions(
          text: "Edit",
          class: "primary",
          icon: "edit",
          url: edit_admin_settings_<~~ lowercase_name ~~>_path,
          permission: policy(@entry).edit?,
          data: { widget: "crud", action: "edit" }
      )

      render "admin/crud/show"
    end

    private

    def load_entry
      @entry = SiteSettings::<~~ class_name ~~>.instance
    end

    def entry_params
      allowed_attrs = set_allowed_attrs
      params.require(:site_settings_<~~ lowercase_name ~~>).permit(*allowed_attrs)
    end

    def set_breadcrumb
      semantic_breadcrumb "Settings", admin_settings_root_path
      semantic_breadcrumb "<~~ class_name ~~>", ''
    end
  end
end

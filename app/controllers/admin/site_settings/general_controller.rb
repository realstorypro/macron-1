require_dependency "application_controller"

module Admin::SiteSettings
  class GeneralController < MetaController
    include AdminAccess
    layout "layouts/admin"

    skip_before_action :load_entry
    before_action :set_breadcrumb

    def show
      @entry = SiteSettings::General.instance

      add_to_actions(
          text: "Edit",
          class: "primary",
          icon: "edit",
          url: edit_admin_settings_general_path,
          permission: policy(@entry).edit?,
          data: { widget: "crud", action: "edit" }
      )
    end

    def edit
      @entry = SiteSettings::General.instance
      render :edit, layout: false
    end

    def update
      @entry = SiteSettings::General.instance
      if @entry.update(entry_params)
        flash[:success] = "settings were successfully updated."
        response_status :success
      else
        response_status :error
        render :edit, layout: false
      end
    end

    def set_breadcrumb
      semantic_breadcrumb 'Settings', admin_settings_root_path
      semantic_breadcrumb 'General', admin_settings_general_path
    end
  end
end

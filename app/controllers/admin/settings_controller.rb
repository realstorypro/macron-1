# frozen_string_literal: true

require_dependency "genesis/application_controller"

module Admin
  class SettingsController < MetaController
    include SettingsHelper
    include PathHelper
    include Genesis::AdminAccess
    layout "genesis/layouts/admin"

    before_action :set_breadcrumb

    def index
      @entry = Genesis::Setting.instance

      add_to_actions(
        text: "Edit Settings",
        class: "primary",
        icon: "edit",
        url: edit_admin_setting_path(@entry),
        permission: policy(@entry).edit?,
        data: { widget: "crud", action: "edit" }
      )
    end

    def edit
      @entry = Genesis::Setting.instance
      render :edit, layout: false
    end

    def update
      @entry = Genesis::Setting.instance
      if @entry.update(entry_params)
        flash[:success] = "settings were successfully updated."
        response_status :success
      else
        response_status :error
        render :edit, layout: false
      end
    end

    private

      def set_breadcrumb
        semantic_breadcrumb "Settings"
      end
  end
end

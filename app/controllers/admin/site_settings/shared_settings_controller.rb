# frozen_string_literal: true

require_dependency "application_controller"

module Admin::SiteSettings
  class SharedSettingsController < MetaController
    include AdminAccess
    layout "layouts/admin"

    before_action :append_actions, only: :show

    private
      def append_actions
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
  end
end

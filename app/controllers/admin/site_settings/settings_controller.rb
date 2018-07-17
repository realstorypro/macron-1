# frozen_string_literal: true

require_dependency "application_controller"

module Admin::SiteSettings
  class SettingsController < ApplicationController
    include AdminAccess
    layout "layouts/admin"
    before_action :set_breadcrumb

    def all
      unless current_user.help
        add_to_actions(
          text: "Show Help",
          class: "",
          icon: "question circle",
          url: enable_help_admin_user_path(current_user.id),
          permission: policy(current_user).enable_help?,
          data: { widget: "clicker", action: "click" }
        )
      end
      if current_user.advanced
        add_to_actions(
          text: "Show Basic",
          class: "secondary",
          icon: "cogs",
          url: disable_advanced_admin_user_path(current_user.id),
          permission: policy(current_user).enable_advanced?,
          data: { widget: "clicker", action: "click" }
        )
      else
        add_to_actions(
          text: "Show Advanced",
          class: "secondary",
          icon: "cogs",
          url: enable_advanced_admin_user_path(current_user.id),
          permission: policy(current_user).enable_advanced?,
          data: { widget: "clicker", action: "click" }
        )
      end
    end

    private
      def set_breadcrumb
        semantic_breadcrumb "Settings", admin_settings_root_path
      end

      # adds actions to the action list
      def add_to_actions(action)
        @actions ||= []
        @actions << action
      end
  end
end
# frozen_string_literal: true

require_dependency "application_controller"

module Admin
  class UsersController < CrudController
    def index
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
      @entries = entry_class.all.order("users.created_at desc")
      render "admin/crud/index"
    end

    def show
      unless @entry.id == current_user.id
        add_delete_ability
        add_edit_ability
        add_ban_ability unless @entry.has_role?(:banned) || @entry.has_role?(:admin)
        add_unban_ability if @entry.has_role?(:banned)
      end

      semantic_breadcrumb @entry.email, "#"
      render "admin/crud/show"
    end

    # handles banning users
    def ban
      entry_class
      load_entry
      @entry.ban!
      redirect_to helpers.meta_show_path @entry.id, determine_namespace
    end

    def unban
      entry_class
      load_entry
      @entry.unban!
      redirect_to helpers.meta_show_path @entry.id, determine_namespace
    end

    def enable_help
      entry_class
      load_entry
      @entry.enable_help!
      redirect_back(fallback_location: admin_root_path)
    end

    def disable_help
      entry_class
      load_entry
      @entry.disable_help!
      redirect_back(fallback_location: admin_root_path)
    end

    def enable_advanced
      entry_class
      load_entry
      @entry.enable_advanced!
      redirect_back(fallback_location: admin_root_path)
    end

    def disable_advanced
      entry_class
      load_entry
      @entry.disable_advanced!
      redirect_back(fallback_location: admin_root_path)
    end



    private

      def add_delete_ability
        add_to_actions(
          text: "Delete #{component_name.singularize}",
          class: "basic",
          icon: "remove",
          url: send(delete_path("admin"), @entry),
          permission: policy(@entry).destroy?,
          data: {
            method: "delete",
            confirm: "Are you sure you want to delete this #{component_name.downcase.singularize}?"
          }
        )
      end

      def add_edit_ability
        add_to_actions(
          text: "Edit #{component_name.singularize}",
          class: "primary",
          icon: "edit",
          url: send(edit_path("admin"), @entry),
          permission: policy(@entry).edit?,
          data: { widget: "crud", action: "edit" }
        )
      end

      def add_ban_ability
        add_to_actions(
          text: "Ban #{component_name.singularize}",
          class: "black",
          icon: "ban",
          url: ban_admin_user_path(@entry),
          permission: policy(@entry).ban?,
          data: { widget: "clicker", action: "click" }
        )
      end

      def add_unban_ability
        add_to_actions(
          text: "Unban #{component_name.singularize}",
          class: "green",
          icon: "ban",
          url: unban_admin_user_path(@entry),
          permission: policy(@entry).unban?,
          data: { widget: "clicker", action: "click" }
        )
      end
  end
end

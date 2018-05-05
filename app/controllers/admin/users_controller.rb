# frozen_string_literal: true

require_dependency "genesis/application_controller"

module Admin
  class UsersController < CrudController
    def index
      @entries = entry_class.all.order("genesis_users.created_at desc")
      render "genesis/admin/crud/index"
    end

    def show
      unless @entry.id == current_user.id
        add_delete_ability
        add_edit_ability
        add_ban_ability unless @entry.has_role?(:banned) || @entry.has_role?(:admin)
        add_unban_ability if @entry.has_role?(:banned)
      end

      semantic_breadcrumb @entry.email, "#"
      render "genesis/admin/crud/show"
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
          icon: "block",
          url: ban_admin_user_path(@entry),
          permission: policy(@entry).ban?,
          data: {
            confirm: "Are you sure you want to ban this #{component_name.downcase.singularize}?"
          }
        )
      end

      def add_unban_ability
        add_to_actions(
          text: "Unban #{component_name.singularize}",
          class: "green",
          icon: "block",
          url: unban_admin_user_path(@entry),
          permission: policy(@entry).unban?,
          data: {
            confirm: "Are you sure you want to unban this #{component_name.downcase.singularize}?"
          }
        )
      end
  end
end

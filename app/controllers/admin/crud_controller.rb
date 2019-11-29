# frozen_string_literal: true

module Admin
  class CrudController < MetaController
    include AdminAccess
    layout "layouts/admin"
    before_action :set_breadcrumb

    def index
      super
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
      add_to_actions(
        text: "New",
        class: "primary enhanced",
        icon: "plus circle",
        url: send(new_path("admin")),
        permission: policy(@entries).new?,
        data: { widget: "crud", action: "new" }
      )
    end

    def show
      super
      add_to_actions(
        text: "Delete",
        class: "negative enhanced",
        icon: "eraser",
        id: "delete-button",
        url: send(delete_path("admin"), @entry),
        permission: policy(@entry).destroy?,
        data: {
          method: "delete",
          confirm: "Are you sure you want to delete this #{component.name.downcase.singularize}?"
        }
      )

      add_to_actions(
        text: "Edit",
        class: "primary enhanced",
        icon: "edit",
        id: "edit-button",
        url: send(edit_path("admin"), @entry.id),
        permission: policy(@entry).edit?,
        data: { widget: "crud", action: "edit" }
      )

      if s("components.#{params[:component]}.focusable")
        if current_user.advanced
          add_to_actions(
            text: "Exit Advanced Mode",
            class: "white left floated hidden",
            dynamic: true,
            icon: "exclamation circle",
            id: "advanced-mode",
            url: disable_advanced_admin_user_path(current_user.id),
            permission: policy(current_user).enable_advanced?,
            data: { widget: "clicker", action: "click" }
          )
        else
          add_to_actions(
            text: "Advanced Mode",
            class: "white left floated hidden",
            dynamic: true,
            icon: "exclamation circle",
            id: "advanced-mode",
            url: enable_advanced_admin_user_path(current_user.id),
            permission: policy(current_user).enable_advanced?,
            data: { widget: "clicker", action: "click" }
          )
        end
        add_to_actions(
          text: "Writer Mode",
          class: "grey enhanced right floated",
          id: "focus-mode",
          url: send(preview_path, @entry.category.slug, @entry.slug),
          permission: policy(@entry).edit?,
          data: { widget: "focus", action: "focus" }
        ) unless @entry.category.nil?
        add_to_actions(
          text: "Mobile Preview",
          class: "blue enhanced hidden",
          id: "mobile-browser-preview",
          url: send(preview_path, @entry.category.slug, @entry.slug),
          permission: policy(@entry).edit?,
          data: { widget: "previewer", action: "mobile" }
        ) unless @entry.category.nil?

        add_to_actions(
          text: "Desktop Preview",
          class: "purple enhanced hidden",
          id: "desktop-browser-preview",
          url: send(preview_path, @entry.category.slug, @entry.slug),
          permission: policy(@entry).edit?,
          data: { widget: "previewer", action: "desktop" }
        ) unless @entry.category.nil?
      end

      semantic_breadcrumb @entry.name.truncate(30), "#"
    end

    def set_breadcrumb
      semantic_breadcrumb component.name, index_path("admin")
    end
  end
end

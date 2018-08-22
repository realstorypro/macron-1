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
      unless current_user.help
        add_to_actions(
          text: "Help",
          class: "black",
          icon: "question circle",
          url: enable_help_admin_user_path(current_user.id),
          permission: policy(current_user).enable_help?,
          data: { widget: "clicker", action: "click" }
        )
      end
      add_to_actions(
        text: "Delete",
        class: "negative enhanced",
        icon: "eraser",
        url: send(delete_path("admin"), @entry),
        permission: policy(@entry).destroy?,
        data: {
          method: "delete",
          confirm: "Are you sure you want to delete this #{component_name.downcase.singularize}?"
        }
      )

      add_to_actions(
        text: "Edit",
        class: "primary enhanced",
        icon: "edit",
        url: send(edit_path("admin"), @entry),
        permission: policy(@entry).edit?,
        data: { widget: "crud", action: "edit" }
      )
      semantic_breadcrumb @entry.name.truncate(30), "#"
    end

    def set_breadcrumb
      semantic_breadcrumb component_name, index_path("admin")
    end
  end
end

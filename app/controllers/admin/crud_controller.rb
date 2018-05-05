# frozen_string_literal: true

# frozen_string_literal: true

module Admin
  class CrudController < MetaController
    include Genesis::AdminAccess
    layout "genesis/layouts/admin"
    before_action :set_breadcrumb

    def index
      super
      add_to_actions(
        text: "Add new #{component_name.downcase.singularize}",
        class: "primary",
        icon: "file",
        url: send(new_path("admin")),
        permission: policy(@entries).new?,
        data: { widget: "crud", action: "new" }
      )
    end

    def show
      add_to_actions(
        text: "Delete #{component_name.downcase.singularize}",
        class: "negative basic",
        icon: "remove",
        url: send(delete_path("admin"), @entry),
        permission: policy(@entry).destroy?,
        data: {
          method: "delete",
          confirm: "Are you sure you want to delete this #{component_name.downcase.singularize}?"
        }
      )

      add_to_actions(
        text: "Edit #{component_name.downcase.singularize}",
        class: "primary",
        icon: "edit",
        url: send(edit_path("admin"), @entry),
        permission: policy(@entry).edit?,
        data: { widget: "crud", action: "edit" }
      )
      semantic_breadcrumb @entry.name.truncate(60), "#"
    end

    def set_breadcrumb
      semantic_breadcrumb component_name, index_path("admin")
    end
  end
end

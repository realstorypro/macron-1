# frozen_string_literal: true

module Admin
  class EntryCrudController < CrudController
    include AdminAccess
    layout "layouts/admin"
    before_action :set_breadcrumb

    def index
      super
    end

    def show
      super
      add_to_actions(
        text: "Desktop Preview",
        class: "purple enhanced hidden",
        id: "desktop-browser-preview",
        url: send(preview_path, @entry.category.slug, @entry.slug),
        permission: policy(@entry).edit?,
        data: { widget: "previewer", action: "desktop" }
      )

      add_to_actions(
          text: "Mobile Preview",
          class: "blue enhanced hidden",
          id: "mobile-browser-preview",
          url: send(preview_path, @entry.category.slug, @entry.slug),
          permission: policy(@entry).edit?,
          data: { widget: "previewer", action: "mobile" }
      )

      add_to_actions(
        text: "Writer Mode",
        class: "grey enhanced",
        id: "focus-mode",
        url: send(preview_path, @entry.category.slug, @entry.slug),
        permission: policy(@entry).edit?,
        data: { widget: "focus", action: "focus" }
      )
    end

    def set_breadcrumb
      semantic_breadcrumb component_name, index_path("admin")
    end
  end
end

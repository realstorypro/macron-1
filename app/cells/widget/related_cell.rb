# frozen_string_literal: true

module Widget
  class RelatedCell < BaseCell
    cache :show do
      options[:entry_id].to_s + model.cache_key
    end

    def show_icon(item, options = {})
      defaults = { size: "", style: "bordered", contrast: "" }
      options = defaults.merge(options)

      if item.type == "Article"
        icon("#{options[:style]} newspaper outline #{options[:contrast]} #{options[:size]}")
      elsif item.type == "Video"
        icon("#{options[:style]} video #{options[:contrast]} #{options[:size]}")
      elsif item.type == "Discussion"
        icon("#{options[:style]} comments #{options[:contrast]} #{options[:size]}")
      end
    end

    def show_link(item)
      if item.type == "Article"
        url_helpers.article_details_path(item.category.slug, item.slug)
      elsif item.type == "Video"
        url_helpers.video_details_path(item.category.slug, item.slug)
      elsif item.type == "Discussion"
        url_helpers.discussion_details_path(item.category.slug, item.slug)
      end
    end
  end
end

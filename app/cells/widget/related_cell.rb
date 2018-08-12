# frozen_string_literal: true

module Widget
  class RelatedCell < BaseCell
    def show_icon(item, options = {})
      defaults = { size: "", style: "bordered", contrast: "inverted" }
      options = defaults.merge(options)

      if item.type == "Article"
        icon("#{options[:style]} newspaper outline #{options[:contrast]} #{options[:size]}")
      elsif item.type == "Video"
        icon("#{options[:style]} video #{options[:contrast]} #{options[:size]}")
      elsif item.type == "Discussion"
        icon("#{options[:style]} comments #{options[:contrast]} #{options[:size]}")
      elsif item.type == "Podcast"
        icon("#{options[:style]} podcast #{options[:contrast]} #{options[:size]}")
      elsif item.type == "Event"
        icon("#{options[:style]} calendar alternate outline #{options[:contrast]} #{options[:size]}")
      end
    end

    def show_link(item)
      if item.type == "Article"
        url_helpers.article_details_path(item.category.slug, item.slug)
      elsif item.type == "Video"
        url_helpers.video_details_path(item.category.slug, item.slug)
      elsif item.type == "Discussion"
        url_helpers.discussion_details_path(item.category.slug, item.slug)
      elsif item.type == "Podcast"
        url_helpers.podcast_details_path(item.category.slug, item.slug)
      elsif item.type == "Event"
        url_helpers.event_details_path(item.category.slug, item.slug)
      end
    end
  end
end

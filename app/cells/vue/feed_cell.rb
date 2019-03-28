# frozen_string_literal: true


module Vue
  class FeedCell < Cell::ViewModel
    include ApplicationHelper
    include ActionView::Helpers::DateHelper
    include DcUi::Helpers

    delegate :url_helpers, to: "::Rails.application.routes"

    def comments
      options[:comments]
    end

    def render_link(comment)
      item = find_entry(comment)
      link_to(item.name, link_path(item))
    end

    def render_date(comment)
      "#{time_ago_in_words(comment.created_at)} ago"
    end

    # shows a different icon based on the item type
    # currently unused
    def show_icon(comment)
      item = find_entry(comment)

      if item.type == "Article"
        raw("#{icon('newspaper outline')}")
      elsif item.type == "Video"
        raw("#{icon('video')}")
      elsif item.type == "Discussion"
        raw("#{icon('comments')}")
      elsif item.type == "Podcast"
        raw("#{icon('podcast')}")
      end
    end


    def link_path(item)
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

    def find_entry(comment)
      @model.each { |entry| return entry if entry.id == comment.commentable_id }
    end
  end
end

# frozen_string_literal: true


module Vue
  class FeedCell < Cell::ViewModel
    include ApplicationHelper
    include DcUi::Helpers

    delegate :url_helpers, to: "::Rails.application.routes"

    def find_date(item)
      comment = comments.find { |comment| comment.commentable_id = item.id}
      comment.created_at
    end

    def comments
      options[:comments]
    end

    def show_icon(item)
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

    def show_link(item)
      if item.type == "Article"
        url_helpers.article_details_path(item.category.slug, item.slug)
      elsif item.type == "Video"
        url_helpers.video_details_path(item.category.slug, item.slug)
      elsif item.type == "Discussion"
        url_helpers.discussion_details_path(item.category.slug, item.slug)
      elsif item.type == "Podcast"
        url_helpers.podcast_details_path(item.category.slug, item.slug)
      end
    end
  end
end

# frozen_string_literal: true
module EntryHelper
  # returns the url of the entry based on its type
  def entry_url(entry)
    if entry.type == "Article"
      article_details_url(entry.category.slug, entry.slug)
    elsif entry.type == "Video"
      video_details_url(entry.category.slug, entry.slug)
    elsif entry.type == "Podcast"
      podcast_details_url(entry.category.slug, entry.slug)
    elsif entry.type == "Discussion"
      discussion_details_url(entry.category.slug, entry.slug)
    end
  end
end

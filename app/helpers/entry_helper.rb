# frozen_string_literal: true

module EntryHelper
  # returns the url of the entry based on its type
  def entry_url(entry)
    if entry.type == "Article"
      article_details_url(entry.category.slug, entry.slug)
    elsif entry.type == "Video"
      video_details_url(entry.category.slug, entry.slug)
    elsif entry.type == "Discussion"
      discussion_details_url(entry.category.slug, entry.slug)
    end
  end

  # returns long date of the entry in RFC882 Form
  def long_published_date(entry)
    Time.new(entry.published_date.year, entry.published_date.month, entry.published_date.day).to_formatted_s(:rfc822)
  end
end

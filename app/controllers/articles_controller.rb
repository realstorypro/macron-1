# frozen_string_literal: true

# handles the display of the article model
class ArticlesController < Genesis::DisplayController
  def show
    return true if @entry.tags.empty?
    @related_discussions = Tag.find_by_id(@entry.tags.map(&:id))
                              .discussions.order("random()").limit(3)
    @ads = Tag.find_by_id(@entry.tags.map(&:id))
              .advertisements.order("random()").limit(1)
  end
end

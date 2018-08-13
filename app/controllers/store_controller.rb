# frozen_string_literal: true

class StoreController < DisplayController
  def fetch_categories
    @categories = Category.joins(:products).distinct(:id).order(:name)
  end
end

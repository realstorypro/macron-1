# frozen_string_literal: true

class StoreController < DisplayController
  def index
    @entries = if params[:category]
      component.klass.joins(:category)
          .where(categories: { slug: params[:category] })
          .order("name asc")
          .page params[:page]
    else
      component.klass.all.order("name asc").page params[:page]
    end
    authorize @entries
  end

  def fetch_categories
    @categories = Category.joins(:products).distinct(:id).order(:name)
  end
end

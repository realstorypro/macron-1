# frozen_string_literal: true

class EventsController < DisplayController
  def index
    @entries = if params[:category]
                 entry_class.joins(:category)
                     .where(categories: { slug: params[:category] })
                     .order("published_date desc")
                     .page params[:page]
               else
                 entry_class.all.order("(payload ->> 'start_date')::timestamptz ASC").page params[:page]
               end
    authorize @entries
  end
end

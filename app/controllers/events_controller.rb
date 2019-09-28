# frozen_string_literal: true

class EventsController < DisplayController
  def index
    @entries = if params[:category]
      component.klass.joins(:category)
          .where(categories: { slug: params[:category] })
          .order("(payload ->> 'start_date')::timestamptz ASC")
          .page params[:page]
    else
      component.klass.all.order(Arel.sql("(payload ->> 'start_date')::timestamptz ASC")).page params[:page]
    end
    authorize @entries
  end
end

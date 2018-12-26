# frozen_string_literal: true

class WorkerController < ApplicationController
  layout "layouts/client"
  skip_before_action :verify_authenticity_token, only: :worker

  def worker
    # pull in last 10 entries
    @entries = Entry.joins(category: :color)
                    .where(type: %w(Article Video Podcast Discussion))
                    .where.not(published_date: nil)
                    .includes(category: :color).order("published_date desc")
                    .limit(10)

    @age = @entries.maximum("published_date")

    respond_to do |format|
      format.js { render layout: false }
    end
  end
end

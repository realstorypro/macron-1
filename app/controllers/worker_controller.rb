# frozen_string_literal: true

class WorkerController < ApplicationController
  layout "layouts/client"
  skip_before_action :verify_authenticity_token, only: :worker

  def worker
    respond_to do |format|
      format.js { render layout: false }
    end
  end
end

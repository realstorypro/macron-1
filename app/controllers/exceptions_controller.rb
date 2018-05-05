# frozen_string_literal: true

# frozen_string_literal: true

class ExceptionsController < ApplicationController
  def page_not_found
    respond_to do |format|
      format.html { render layout: "layouts/client", status: 404 }
      format.all  { render nothing: true, status: 404 }
    end
  end

  def forbidden
    respond_to do |format|
      format.html { render layout: "layouts/client", status: 403 }
      format.all  { render nothing: true, status: 403 }
    end
  end

  def server_error
    respond_to do |format|
      format.html { render layout: "layouts/error", status: 500 }
      format.all  { render nothing: true, status: 500 }
    end
  end
end

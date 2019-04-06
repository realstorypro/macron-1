# frozen_string_literal: true

module Vue
  class FeedCell < Cell::ViewModel
    include ApplicationHelper
    include ActionView::Helpers::DateHelper
    include DcUi::Helpers

    delegate :url_helpers, to: "::Rails.application.routes"

    def stream_token
      options[:stream_token]
    end
  end
end

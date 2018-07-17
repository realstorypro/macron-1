# frozen_string_literal: true

module Vue
  class CoverCell < Cell::ViewModel
    include DcUi::Helpers

    private
      def overlay_background
        options[:overlay_background]
      end
  end
end

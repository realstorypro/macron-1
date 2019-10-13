# frozen_string_literal: true

module Vue
  class VideoCell < Cell::ViewModel
    include GoodUi::Helpers

    def player_id
      @id ||= rand(1..10000)
    end
  end
end

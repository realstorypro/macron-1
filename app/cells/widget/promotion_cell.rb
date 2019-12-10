# frozen_string_literal: true

module Widget
  class PromotionCell < BaseCell
    cache :show do
      [model.first.id, model.first.updated_at]
    end
  end
end

# frozen_string_literal: true

module Widget
  class PromotionCell < BaseCell
    cache :show do
      options[:entry_id].to_s + model.cache_key
    end
  end
end

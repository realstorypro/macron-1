# frozen_string_literal: true

module Widget
  class ProfileFilterCell < BaseCell
    def categories
      options[:categories]
    end

    def active_category
      options[:active_category]
    end
  end
end

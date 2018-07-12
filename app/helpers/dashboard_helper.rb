# frozen_string_literal: true

module DashboardHelper
  def statistic_class(value)
    if value > 0
      "green"
    else
      "red"
    end
  end
end

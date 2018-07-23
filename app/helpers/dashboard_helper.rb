# frozen_string_literal: true

module DashboardHelper
  def statistic_class(value)
    if value > 0
      "green"
    else
      "red"
    end
  end

  def stat_color(current, previous)
    if current >= previous
      "green"
    else
      "red"
    end
  end

  def stat_icon(current, previous)
    if current >= previous
      icon('green up double angle tiny')
    else
      icon('red down double angle tiny')
    end
  end
end

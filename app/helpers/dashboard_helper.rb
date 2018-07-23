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
      icon("green up double angle mini")
    else
      icon("red down double angle mini")
    end
  end

  def stat_counter(current, previous, percent = false)
    difference = current - previous
    difference = difference.round(2) if percent
    if difference == 0
      "( +0 )"
    elsif difference > 0
      "( +#{difference} )"
    elsif difference < 0
      "( #{difference} )"
    end
  end
end

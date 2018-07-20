# frozen_string_literal: true

module ApplicationHelper
  include SettingsHelper
  include PathHelper
  include UserHelper
  include CrudHelper
  include ImageHelper
  include MenuHelper

  def reversed_class(order)
    "computer reversed" if order == "reversed"
  end
end

# frozen_string_literal: true

GoodUi.configure do |config|
  config.ui_file = "#{Rails.root}/config/ui.yml"
end

GoodUi.boot

# frozen_string_literal: true

DcUi.configure do |config|
  config.ui_file = "#{Genesis::Engine.root}/config/ui.yml"
end

DcUi.boot

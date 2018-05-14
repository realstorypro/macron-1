# frozen_string_literal: true

namespace :colors do
  desc "Setting up colors "
  task setup: :environment do
    Settings.colors.each do |color|
      Color.find_or_create_by name: color
    end
  end

  desc "Delete all colors"
  task delete_all: :environment do
    Color.delete_all
  end
end

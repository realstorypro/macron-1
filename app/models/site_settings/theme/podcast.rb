# frozen_string_literal: true

module SiteSettings::Theme
  class Podcast < Setting
    include Autoloadable

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Podcast.exists?
    end

    def self.instance
      Podcast.first_or_create! do |settings|
        settings.menu_style = "transparent"
      end
    end
  end
end

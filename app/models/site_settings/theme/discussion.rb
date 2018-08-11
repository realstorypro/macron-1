# frozen_string_literal: true

module SiteSettings::Theme
  class Discussion < Setting
    include Autoloadable

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Discussion.exists?
    end

    def self.instance
      Discussion.first_or_create! do |settings|
        settings.menu_style = "transparent"
      end
    end
  end
end

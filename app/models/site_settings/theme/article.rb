# frozen_string_literal: true

module SiteSettings::Theme
  class Article < Setting
    include Autoloadable

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Article.exists?
    end

    def self.instance
      Article.first_or_create! do |settings|
        settings.menu_style = "transparent"
      end
    end
  end
end

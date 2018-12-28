# frozen_string_literal: true

module SiteSettings::Theme
  class Video < Setting
    include Autoloadable

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Video.exists?
    end

    validates_presence_of :menu_style
    content_attr :menu_style, :string

    def self.instance
      Video.first_or_create!
    end
  end
end

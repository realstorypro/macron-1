# frozen_string_literal: true

module SiteSettings::Theme
  class Header < Setting
    include Autoloadable

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Header.exists?
    end

    def self.instance
      Header.first_or_create!
    end
  end
end

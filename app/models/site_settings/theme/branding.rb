# frozen_string_literal: true

module SiteSettings::Theme
  class Branding < Setting
    include Autoloadable

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Branding.exists?
    end

    def self.instance
      Branding.first_or_create!
    end
  end
end

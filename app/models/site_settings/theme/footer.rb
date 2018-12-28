# frozen_string_literal: true

module SiteSettings::Theme
  class Footer < Setting
    include Autoloadable

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Footer.exists?
    end

    def self.instance
      Footer.first_or_create!
    end
  end
end

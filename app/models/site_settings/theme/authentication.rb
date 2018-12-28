# frozen_string_literal: true

module SiteSettings::Theme
  class Authentication < Setting
    include Autoloadable

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Authentication.exists?
    end

    def self.instance
      Authentication.first_or_create!
    end
  end
end

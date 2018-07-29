# frozen_string_literal: true

module SiteSettings
  class Branding < Setting
    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Branding.exists?
    end


    def self.instance
      Branding.first_or_create! do |settings|
      end
    end
  end
end

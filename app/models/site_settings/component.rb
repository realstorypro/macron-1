# frozen_string_literal: true

module SiteSettings
  class Component < Setting
    include Autoloadable

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Component.exists?
    end

    def self.instance
      Component.first_or_create! do |settings|
      end
    end
  end
end

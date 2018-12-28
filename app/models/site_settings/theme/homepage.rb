# frozen_string_literal: true

module SiteSettings::Theme
  class Homepage < Setting
    include Autoloadable

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Homepage.exists?
    end


    def self.instance
      Homepage.first_or_create!
    end
  end
end

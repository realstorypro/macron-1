# frozen_string_literal: true

module SiteSettings
  class <~~ class_name ~~> < Setting
    include Autoloadable

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if <~~ class_name ~~>.exists?
    end

    def self.instance
      <~~ class_name ~~>.first_or_create! do |settings|
      end
    end
  end
end

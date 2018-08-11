# frozen_string_literal: true

module SiteSettings
  class General < Setting
    include Autoloadable

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if General.exists?
    end

    # manually including name since autoloadable ignores it
    content_attr :name, :string
    validates_presence_of :name

    validates :url, url: { schemes: ["https"] }



    def self.instance
      General.first_or_create! do |settings|
        settings.name = "Content hub by Idealogic"
        settings.description = "Short hub description"
        settings.url = "https://hub.idealogic.io"
      end
    end
  end
end

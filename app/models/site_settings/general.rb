# frozen_string_literal: true

module SiteSettings
  class General < Setting
    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if General.exists?
    end

    validates_presence_of :name,
                          :description,
                          :url

    validates :url, url: { schemes: ["https"] }

    content_attr :name, :string
    content_attr :description, :string
    content_attr :url, :string
    content_attr :about, :text
    content_attr :copyrights, :string


    def self.instance
      General.first_or_create! do |settings|
        settings.name = "Content hub by Idealogic"
        settings.description = "Short hub description"
        settings.url = "https://hub.idealogic.io"
      end
    end
  end
end

module SiteSettings
  class General < Setting
    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if General.exists?
    end

    content_attr :name, :string
    content_attr :description, :string
    content_attr :url, :string

    validates_presence_of :name, :description, :url
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

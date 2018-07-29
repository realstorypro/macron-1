module SiteSettings::Theme
  class Podcast < Setting

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Podcast.exists?
    end

    validates_presence_of :menu_style
    content_attr :menu_style, :string

    def self.instance
      Podcast.first_or_create! do |settings|
        settings.menu_style = "transparent"
      end
    end
  end
end

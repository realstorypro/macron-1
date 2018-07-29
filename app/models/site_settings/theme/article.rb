module SiteSettings::Theme
  class Article < Setting

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Article.exists?
    end

    validates_presence_of :menu_style
    content_attr :menu_style, :string

    def self.instance
      Article.first_or_create! do |settings|
        settings.menu_style = "transparent"
      end
    end
  end
end

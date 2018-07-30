module SiteSettings::Theme
  class Discussion < Setting

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Discussion.exists?
    end

    validates_presence_of :discussion_menu_style
    content_attr :discussion_menu_style, :string

    def self.instance
      Discussion.first_or_create! do |settings|
        settings.discussion_menu_style = "transparent"
      end
    end

  end
end
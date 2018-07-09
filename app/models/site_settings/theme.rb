module SiteSettings
  class Theme < Setting
    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Theme.exists?
    end

    content_attr :about, :text
    content_attr :copyrights, :string

    content_attr :sign_up_title, :string
    content_attr :sign_up_subtitle, :string
    content_attr :sign_in_title, :string

    content_attr :auth_background, :string

    def self.instance
      Theme.first_or_create! do |settings|
        settings.about = "about section"
        settings.copyrights = "2017 - 2018 IdeaLogic"
      end
    end

  end
end

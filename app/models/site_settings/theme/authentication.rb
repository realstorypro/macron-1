module SiteSettings::Theme
  class Authentication < Setting

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Authentication.exists?
    end

    validates_presence_of :sign_up_title,
                          :sign_up_subtitle,
                          :sign_in_title

    content_attr :sign_up_title, :string
    content_attr :sign_up_subtitle, :string
    content_attr :sign_in_title, :string
    content_attr :auth_background, :string

    def self.instance
      Authentication.first_or_create! do |settings|
        settings.sign_up_title = "Sign Up"
        settings.sign_up_subtitle = "Join The Community"
        settings.sign_in_title = "Sign In"
      end
    end
  end
end

# frozen_string_literal: true

module SiteSettings
  class Contact < Setting
    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Contact.exists?
    end

    content_attr :phone, :string
    content_attr :email, :string
    content_attr :website, :string
    content_attr :address1, :string
    content_attr :address2, :string
    content_attr :address3, :string


    content_attr :twitter, :string
    content_attr :facebook, :string


    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, allow_blank: true
    validates :facebook, url: { schemes: ["https"] }, allow_blank: true
    validates :website, url: { schemes: %w(http https) }, allow_blank: true

    def self.instance
      Contact.first_or_create! do |settings|
        settings.phone = "800.608.5963"
        settings.email = "support@idealogic.io"
        settings.address1 = "	2 E. Congress St"
        settings.address2 = "Suite 900"
        settings.address3 = "Tucson, Arizona 85701"
        settings.website = "https://www.idealogic.io"

        settings.twitter = "@the_idealogic"
        settings.facebook = "https://www.facebook.com/theidealogic"
      end
    end
  end
end

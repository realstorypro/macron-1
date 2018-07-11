# frozen_string_literal: true

module SiteSettings
  class Contact < Setting
    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Contact.exists?
    end

    content_attr :phone, :string
    content_attr :email, :string
    content_attr :address1, :string
    content_attr :address2, :string
    content_attr :address3, :string


    content_attr :twitter, :string
    content_attr :facebook, :string


    validates_presence_of :address1, :address2

    validates :facebook, url: { schemes: ["https"] }

    def self.instance
      Contact.first_or_create! do |settings|
        settings.address1 = "first line"
        settings.address2 = "second line"

        settings.facebook = "https://www.facebook.com/rungravity"
      end
    end
  end
end

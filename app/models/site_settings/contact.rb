# frozen_string_literal: true

module SiteSettings
  class Contact < Setting
    include Autoloadable

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Contact.exists?
    end

    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, allow_blank: true
    validates :facebook, url: { schemes: ["https"] }, allow_blank: true
    validates :website, url: { schemes: %w(http https) }, allow_blank: true

    def self.instance
      Contact.first_or_create!
    end
  end
end

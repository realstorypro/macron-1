# frozen_string_literal: true

# rubocop:disable GlobalVars

class Setting < ApplicationRecord
  include Payloadable
  after_save :clear_cache

  before_create do
    errors.add(:base, "already one setting object existing") && (return false) if Setting.exists?
  end

  content_attr :name, :string
  content_attr :description, :string
  content_attr :url, :string

  content_attr :phone, :string
  content_attr :email, :string
  content_attr :address1, :string
  content_attr :address2, :string
  content_attr :address3, :string

  content_attr :about, :text
  content_attr :copyrights, :string

  content_attr :twitter, :string
  content_attr :facebook, :string

  content_attr :logo, :string
  content_attr :inverted_logo, :string
  content_attr :desktop_logo_size, :integer
  content_attr :mobile_logo_size, :integer

  content_attr :favicon_16, :string
  content_attr :favicon_32, :string
  content_attr :favicon_96, :string
  content_attr :favicon_120, :string
  content_attr :favicon_152, :string
  content_attr :favicon_167, :string
  content_attr :favicon_180, :string

  content_attr :sign_up_title, :string
  content_attr :sign_up_subtitle, :string
  content_attr :sign_in_title, :string
  content_attr :auth_background, :string

  content_attr :newsletter_webhook, :string

  validates_presence_of :name, :description, :url,
                        :about, :address1,
                        :address2, :copyrights,
                        :logo, :inverted_logo,
                        :newsletter_webhook

  validates :url, url: { schemes: ["https"] }
  validates :facebook, url: { schemes: ["https"] }
  validates :newsletter_webhook, url: { schemes: ["https"] }

  def self.policy_class
    MetaPolicy
  end

  def self.instance
    Setting.first_or_create! do |settings|
      settings.name = "Aquarius Default Title"
      settings.description = "Aquarius Default Description"

      settings.url = "https://www.rungravity.com"
      settings.facebook = "https://www.facebook.com/rungravity"

      settings.about = "about section"
      settings.copyrights = "2017 - 2018 IdeaLogic"

      settings.address1 = "first line"
      settings.address2 = "second line"

      settings.logo = "logo.png"
      settings.inverted_logo = "logo_inverted.png"

      settings.newsletter_webhook = "https://hooks.zapier.com/hooks/catch/3200901/fsym7e/"
    end
  end

  private

    def clear_cache
      $redis.del "site_settings"
    end
end

# rubocop:enable GlobalVars

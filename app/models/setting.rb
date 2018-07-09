# frozen_string_literal: true

# rubocop:disable GlobalVars

class Setting < ApplicationRecord
  include Payloadable
  after_save :clear_cache

  content_attr :phone, :string
  content_attr :email, :string
  content_attr :address1, :string
  content_attr :address2, :string
  content_attr :address3, :string


  content_attr :twitter, :string
  content_attr :facebook, :string


  content_attr :newsletter_webhook, :string

  #validates_presence_of :name, :description, :url,
  #                      :about, :address1,
  #                      :address2, :copyrights,
  #                      :logo, :inverted_logo,
  #                      :newsletter_webhook

  #validates :url, url: { schemes: ["https"] }
  #validates :facebook, url: { schemes: ["https"] }
  #validates :newsletter_webhook, url: { schemes: ["https"] }

  def self.policy_class
    MetaPolicy
  end

  def self.instance
    Setting.first_or_create! do |settings|
      settings.facebook = "https://www.facebook.com/rungravity"


      settings.address1 = "first line"
      settings.address2 = "second line"


      settings.newsletter_webhook = "https://hooks.zapier.com/hooks/catch/3200901/fsym7e/"
    end
  end

  private

    def clear_cache
      $redis.del "site_settings"
    end
end

# rubocop:enable GlobalVars

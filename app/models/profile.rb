# frozen_string_literal: true

class Profile < ApplicationRecord
  include Payloadable
  include Autoloadable

  belongs_to :user

  validates_presence_of :user
  before_save :cleanup_twitter, :cleanup_instagram

  # manually adding the verified state instead of adding it to profile.yml to
  # prevent uers from manually editing it
  content_attr :verified, :boolean

  def erase_profile!
    self.avatar = nil
    self.location = nil
    self.age = nil
    self.signature = nil
    self.title = nil
    self.twitter = nil
    self.instagram = nil
    self.url = nil
    save
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def avatar_with_default
    return avatar unless avatar.nil?
    "default-avatar.jpg"
  end

  def cleanup_twitter
    twitter.tr!("@", "") if twitter.include?("@") unless twitter.blank?
  end

  def cleanup_instagram
    instagram.tr!("@", "") if instagram.include?("@") unless instagram.blank?
  end

  def verify!
    self.verified = true
    save
  end

  def unverify!
    self.verified = false
    save
  end

  def self.policy_class
    ProfilePolicy
  end
end

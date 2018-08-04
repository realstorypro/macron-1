# frozen_string_literal: true

class Profile < ApplicationRecord
  include Payloadable
  include Autoloadable

  belongs_to :user

  validates_presence_of :user

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

  def avatar_with_default
    return avatar unless avatar.nil?
    "default-avatar.jpg"
  end

  def self.policy_class
    ProfilePolicy
  end
end

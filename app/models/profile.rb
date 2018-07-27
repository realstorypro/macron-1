# frozen_string_literal: true

class Profile < ApplicationRecord
  include Payloadable
  belongs_to :user

  content_attr :title, :string
  content_attr :avatar, :string
  content_attr :location, :string
  content_attr :age, :integer
  content_attr :signature, :string
  content_attr :twitter, :string
  content_attr :instagram, :string
  content_attr :url, :string

  content_attr :card_color, :string

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

# frozen_string_literal: true

require "friendly_id"

class Category < ApplicationRecord
  include Slugged
  include Colorizable

  validates :name, presence: true
  validates :color, presence: true

  has_many :entries
  has_many :discussions
  has_many :articles
  has_many :videos
  has_many :podcasts
  has_many :events
  has_many :products

  def self.policy_class
    MetaPolicy
  end
end

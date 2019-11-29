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

  before_destroy :unpublish_entries

  def unpublish_entries
    self.entries.each do |entry|
      entry.published_date = nil
      entry.save(validate: false)
    end
  end

  def self.policy_class
    MetaPolicy
  end
end

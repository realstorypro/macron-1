# frozen_string_literal: true

class Component < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name

  def enable!
    self.enabled = true
    save
  end

  def disable!
    self.enabled = false
    save
  end
end

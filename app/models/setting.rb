# frozen_string_literal: true

# rubocop:disable GlobalVars

class Setting < ApplicationRecord
  include Payloadable

  before_create do
    errors.add(:base, "already one setting object existing") && (return false) if !self.new_record? && self.exists?
  end

  after_save :clear_cache

  def self.instance
    self.first_or_create!
  end

  def self.policy_class
    MetaPolicy
  end

  private

    def clear_cache
      SiteSettingInterface.instance.clear_cache
    end
end

# rubocop:enable GlobalVars

# frozen_string_literal: true

module SiteSettings
  class Component < ApplicationRecord
    validates_presence_of :name
    validates_uniqueness_of :name
    after_save :clear_cache

    def enable!
      self.enabled = true
      save
    end

    def disable!
      self.enabled = false
      save
    end

    private
      def clear_cache
        SiteSettingInterface.instance.clear_cache
      end
  end
end

# frozen_string_literal: true

module Pointable
  extend ActiveSupport::Concern

  included do
    def points
      setting = SettingInterface.new(Settings)

      points = {}
      setting.fetch_setting("spells").each do |spell|
        points[spell[0]] = self.find_votes_for(vote_scope: spell[0]).sum(:vote_weight)
      end

      spells = setting.fetch_setting("spells").each do |spell|
        spell[1][:points] = points[spell[0]]
      end

      spells
    end
  end
end

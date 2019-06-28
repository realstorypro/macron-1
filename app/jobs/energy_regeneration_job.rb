# frozen_string_literal: true

class EnergyRegenerationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.all.each { |user| user.regenerate_energy }
  end
end

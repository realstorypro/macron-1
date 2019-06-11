class EnergyRegenerationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    users = User.all
    users.each do |user|
      user.regenerate_energy
    end
  end
end

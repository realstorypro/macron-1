# frozen_string_literal: true

namespace :roles do
  desc "Sets up available roles"
  task setup: :environment do
    Settings.auth.roles.each do |role|
      Role .find_or_create_by name: role unless role == "guest"
    end
  end
end

# frozen_string_literal: true

# rubocop:disable ClassAndModuleChildren
class Ahoy::Store < Ahoy::DatabaseStore
end

# set to true for JavaScript tracking
Ahoy.api = true
Ahoy.mask_ips = true
Ahoy.server_side_visits = :when_needed
Ahoy.visit_duration = 24.hours
# rubocop:enable ClassAndModuleChildren

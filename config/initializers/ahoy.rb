# frozen_string_literal: true

# rubocop:disable ClassAndModuleChildren
class Ahoy::Store < Ahoy::DatabaseStore
  def authenticate(data)
    # disables automatic linking of visits and users
  end
end

# set to true for JavaScript tracking
Ahoy.api = true
# rubocop:enable ClassAndModuleChildren

Ahoy.mask_ips = true
Ahoy.cookies = false

# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout "layouts/auth"
end

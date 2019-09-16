# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout "layouts/auth"

  def destroy
    # clear the cached headers
    # this makes the link preloader reload all the links
    # and show the html for logged-out users
    response.headers["Clear-Site-Data"] = "cache"
    super
  end
end

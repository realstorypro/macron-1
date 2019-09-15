# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SettingsHelper

  include Pundit
  include SiteSettings
  include Trackable

  layout :layout_by_resource

  # only do the 2fa if we're not on devise controller
  before_action :after_sign_in_2fa, unless: :devise_controller?

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # TODO Refactor out BreadcumbsHelper
  helper SemanticBreadcrumbsHelper

  def pundit_user
    UserContext.new(current_user, params)
  end

  def user_not_authorized
    redirect_to("/403", status: 403)
  end

    private
      def layout_by_resource
        if devise_controller?
          "auth"
        else
          "client"
        end
      end


      def after_sign_in_2fa
        # we obvisouly don't want to preform 2fa if the user isn't signed
        return false unless current_user

        # redirect to the phone verification controller if the session isn't verified
        redirect_to edit_phone_path unless session[:verified]
      end
end

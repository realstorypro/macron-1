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

  # Warden::Manager.after_authentication do |user, _, __|
  #   # Directly calling the AnalyticsProxy directly,
  #   #   because we're under Warden and Trackable is not available.
  #   AnalyticsProxy.instance.identify(user)
  # end

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
        
        # if the phone number is blank we want to send people to set phone number
        if current_user.phone_number.blank?
          redirect_to edit_phone_path action: :set_phone_number
        elsif phone_needs_verification?
          redirect_to phone_verify_path action: :validate_phone_number
        end
      end

      def phone_needs_verification?
        # we need to run a verification if the session has not been verified
        return true if session[:verified].nil?

        # if the user updates the country then the phone number gets unverified
        # therefore we need to run run this verification even if the session verified
        return true unless current_user.phone_verified
      end
end

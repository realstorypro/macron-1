# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SettingsHelper

  include Pundit
  include SiteSettings
  include Trackable


  #before_action :store_user_location!, if: :storable_location?
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
      # Its important that the location is NOT stored if:
      # - The request method is not GET (non idempotent)
      # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
      #    infinite redirect loop.
      # - The request is an Ajax request as this can lead to very unexpected behaviour.
      # TODO add verification and profile wizard controllers here ...
      # def storable_location?
      #   request.get? &&
      #       is_navigational_format? &&
      #       !devise_controller? &&
      #       !(request.controller_class == AfterSignupController) &&
      #       !request.xhr?
      # end

      # def store_user_location!
      #   # :user is the scope we are authenticating
      #   store_location_for(:user, request.fullpath)
      #   session[:current_location] = request.fullpath
      # end

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

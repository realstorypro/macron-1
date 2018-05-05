# frozen_string_literal: true

# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  include SiteSettings
  include SettingsHelper

  before_action :store_user_location!, if: :storable_location?

  # TODO: enable 2fa under aquarius refactor
  # before_action :after_sign_in, unless: :devise_controller? || current_user.nil?

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

  Warden::Manager.after_authentication do |user, auth, opts|
    Analytics.identify(
      user_id: user.id,
      traits: {
          username: user.username,
          email: user.email,
          avatar: user.profile.avatar,
          created_at: user.created_at
      })
  end

    private

      # Its important that the location is NOT stored if:
      # - The request method is not GET (non idempotent)
      # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
      #    infinite redirect loop.
      # - The request is an Ajax request as this can lead to very unexpected behaviour.
      # TODO add verification and profile wizard controllers here ...
      def storable_location?
        request.get? &&
            is_navigational_format? &&
            !devise_controller? &&
            !(request.controller_class == AfterSignupController) &&
            !request.xhr?
      end

      def store_user_location!
        # :user is the scope we are authenticating
        store_location_for(:user, request.fullpath)
        session[:current_location] = request.fullpath
      end

      def after_sign_in
        # TODO: this can probably be removed since we're checking at the top,
        # but not now since we're not testing this
        return true if current_user.nil?

        redirect_to after_signup_path(:set_phone_number) if current_user.phone_number.blank?
        redirect_to after_signup_path(:validate_phone_number) if needs_verification?
      end

      def needs_verification?
        # we can't run a verification if the phone number if blank
        return false if current_user.phone_number.blank?

        # we need to run a verification if the session has not been verified
        return true if session[:verified].nil?

        # we need to run a verification if the phone number is not verified
        return true unless current_user.phone_verified
      end
end

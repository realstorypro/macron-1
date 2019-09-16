# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  layout "layouts/auth"

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_country_codes, only: [:edit, :update]
  before_action :check_for_verified_session, only: [:edit, :update]

  def create
    super do |created_user|
      unless created_user.id.nil?
        track(
          event: "User Registered",
          props: {
              username: created_user.username,
              email: created_user.email
          }
        )

        if created_user.newsletter == "1"
          track(
            event: "Subscription Created",
            props: {
                email: created_user.email,
                location: "signup"
            }
          )
        end
      end
    end
  end

  def update
    # we want to un-verify the session if the phone number has changed
    pre_update_phone_number = resource.phone_number
    super do |updated_user|
      session[:verified]= false if updated_user.phone_number != pre_update_phone_number
    end
  end

  private
    def check_for_verified_session
      redirect_to root_path unless session[:verified]
    end

    def configure_permitted_parameters
      added_attrs = %i(username email password password_confirmation remember_me newsletter phone_number country)
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end

    def load_country_codes
      country_codes = IsoCountryCodes.for_select.select do |country|
        country[0].include?("United States of America") ||
            country[0] == "Brazil" ||
            country[0] == "Canada" ||
            country[0] == "Spain" ||
            country[0] == "Portugal" ||
            country[0] == "India" ||
            country[0] == "Japan" ||
            country[0] == "China" ||
            country[0] == "Israel" ||
            country[0] == "Russian Federation" ||
            country[0] == "United Kingdom of Great Britain and Northern Ireland"
      end

      country_codes.sort_by! { |m| m[0].downcase }

      uk_index = country_codes.index { |country| country[0] == "United Kingdom of Great Britain and Northern Ireland" }
      country_codes[uk_index][0] = "United Kingdom"

      us_index = country_codes.index { |country| country[0] == "United States of America" }
      us_country = country_codes.delete_at(us_index)
      country_codes.unshift us_country
      @country_codes = country_codes
    end
end

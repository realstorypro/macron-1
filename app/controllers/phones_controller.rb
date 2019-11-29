# frozen_string_literal: true

# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Lint/EmptyWhen
# rubocop:disable Metrics/AbcSize
require_dependency "application_controller"

class PhonesController < ApplicationController
  layout "layouts/auth"

  # don't do the 2fa since we do it here
  skip_before_action :after_sign_in_2fa
  before_action :set_country_codes, only: %i[edit update]

  def edit
    # We want to make sure that the phone number can not be edited
    # if it has already been verified.
    # This prevents unauthorized phone number change
    redirect_to phone_verify_path if current_user.phone_verified
  end

  def update
    if current_user.update(user_params)
      redirect_to phone_verify_path
    else
      render :edit, flash: { error: current_user.errors }
    end
  end

  def verify
    client = Twilio::REST::Client.new
    session[:otp_number] = rand.to_s[2..5]

    country_prefix = ISO3166::Country.find_country_by_alpha2(current_user.country).country_code


    begin
      client.messages.create({
         from: ENV["TWILIO_PHONE_NUMBER"],
         to: "+#{country_prefix}#{current_user.phone_number}",
         body: "Your Verification Code is #{session[:otp_number]}"
      })
    rescue => exception
      redirect_to edit_phone_path, flash: { error: "The phone number you've entered is invalid." }
      return
    end

  end

  def verify_otp
    if params[:verification][:code] && params[:verification][:code] == session[:otp_number]
      # verifies the session
      session[:verified] = true

      # sets the phone number as verified
      current_user.update(phone_verified: true)

      # clear the cached headers
      # this makes the link preloader reload all the links
      # and show the html for logged-in users
      response.headers["Clear-Site-Data"] = "cache"

      if session[:current_location ]
        redirect_to session[:current_location],
                    turbolinks: false,
                    flash: { success: "You've been signed in successfully." }
      else
        redirect_to root_path,
                    turbolinks: false,
                    flash: { success: "You've been signed in successfully." }
      end
    else
      redirect_to phone_verify_path, flash: { error: "The code you've entered is incorrect." }
    end
  end

  def set_country_codes
    @country_codes = country_codes
  end

  private
    def country_codes
      country_codes = IsoCountryCodes.for_select

      country_codes.sort_by! { |m| m[0].downcase }

      us_index = country_codes.index { |country| country[0] == "United States of America" }
      us_country = country_codes.delete_at(us_index)
      country_codes.unshift us_country
      country_codes
    end

    def user_params
      params.require(:user).permit(:country, :phone_number)
    end
end
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Lint/EmptyWhen
# rubocop:enable Metrics/AbcSize

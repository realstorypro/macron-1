# frozen_string_literal: true

# rubocop:disable CyclomaticComplexity
# rubocop:disable PerceivedComplexity
# rubocop:disable EmptyWhen
# rubocop:disable AbcSize
require_dependency "application_controller"

class PhonesController < ApplicationController
  layout "layouts/auth"

  # don't do the 2fa since we do it here
  skip_before_action :after_sign_in_2fa

  def edit
    @user = current_user
    @country_codes = country_codes
  end

  def update
    #first we remove all the non alpha numberic chracters
    params[:user][:phone_number].gsub!(/\D/, "")

    # we strip out country code data
    params[:user][:phone_number] = Phonelib.parse(params[:user][:phone_number], params[:user][:country]).national(false)

    if current_user.update(user_params)
      redirect_to phone_verify_path
    else
      redirect_to edit, flash: {error: current_user.errors}
    end
  end

  def verify
    client = Twilio::REST::Client.new
    session[:otp_number] = rand.to_s[2..5]

    country_prefix = ISO3166::Country.find_country_by_alpha2(current_user.country).country_code


    client.messages.create({
         from: ENV["TWILIO_PHONE_NUMBER"],
         to: "+1#{country_prefix}#{current_user.phone_number}",
         body: "Your Verification Code is #{session[:otp_number]}"
     })
  end

  def verify_otp
    if params[:verification][:code] && params[:verification][:code] == session[:otp_number]
      # verifies the session
      session[:verified] = true

      # sets the phone as verified
      current_user.update(phone_verified: true)
      redirect_to root_path, flash: { success: "You've been signed in successfully." }
    else
      redirect_to phone_verify_path, flash: { error: "The code you've entered is incorrect." }
    end
  end

  private
    def country_codes
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
      country_codes
    end

    def user_params
      params.require(:user).permit(:country, :phone_number)
    end

end
# rubocop:enable CyclomaticComplexity
# rubocop:enable PerceivedComplexity
# rubocop:enable EmptyWhen
# rubocop:enable AbcSize

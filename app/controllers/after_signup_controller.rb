# frozen_string_literal: true

# rubocop:disable CyclomaticComplexity
# rubocop:disable PerceivedComplexity
# rubocop:disable EmptyWhen
# rubocop:disable AbcSize
require_dependency "genesis/application_controller"

class AfterSignupController < ApplicationController
  include Wicked::Wizard
  layout "genesis/layouts/auth"

  before_action :init_nexmo

  # TODO: enable 2fa under aquarius refactor
  # skip_before_action :after_sign_in

  steps :set_phone_number, :validate_phone_number

  def show
    case step
    when :set_phone_number
      @user = current_user
      @country_codes = country_codes
      @user.country = "us" if @user.country.blank?

      jump_to :validate_phone_number if @user.phone_verified
    when :validate_phone_number
      send_authenication_request

      case @verification_request.status
      when "0"
      when "10"
        @nexmo.verify.cancel(@request_id)
        send_authenication_request
      when "3"
        flash[:notice] = "The number is incorrect. Please try another number."
        jump_to :set_phone_number
      when "15"
        flash[:notice] = "The number is not in a supported network. Please try another number."
        jump_to :set_phone_number
      else
        flash[:notice] = "Could not verify your number. Please try another number."
        jump_to :set_phone_number
      end
    end
    render_wizard
  end

  def update
    @user = current_user
    @country_codes = country_codes

    case step
    when :set_phone_number
      @user.country = params[:user][:country]
      @user.phone_number = params[:user][:phone_number]

    when :validate_phone_number
      confirmation = @nexmo.verify.check(request_id: params[:verification][:request_id],
                                         code: params[:verification][:code])

      case confirmation.status
      when "0"
        session[:verified] = true
        @user.phone_verified = true
        flash[:success] = "Verification successful. Welcome #{current_user.username}!"
      when "3"
        flash[:error] = "Verification request is incorrect. Please contact support."
        jump_to :validate_phone_number
      when "16"
        flash[:error] = "Verification code is incorrect. Please re-enter the code."
        jump_to :validate_phone_number
      else
        flash[:error] = confirmation.error_text
        jump_to :validate_phone_number
      end
    end
    render_wizard @user
  end

  def finish_wizard_path
    return session[:current_location] if session[:current_location]
    root_path
  end

  private

    def init_nexmo
      @nexmo = Nexmo::Client.new
    end

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

    # makes auth request returns request id
    def send_authenication_request
      @verification_request = @nexmo.verify.request(country: current_user.country.upcase,
                                                    number: current_user.phone_number,
                                                    brand: ss(:name))
      @request_id = @verification_request.try(:request_id)
    end
end
# rubocop:enable CyclomaticComplexity
# rubocop:enable PerceivedComplexity
# rubocop:enable EmptyWhen
# rubocop:enable AbcSize

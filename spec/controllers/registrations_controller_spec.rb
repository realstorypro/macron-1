# frozen_string_literal: true

require "rails_helper"
include ApplicationHelper


describe Users::RegistrationsController, type: :controller do
  it "unverifies session upon phone number change" do
    user = FactoryBot.create(:user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user

    params = {
      user: {
        id: user.id,
        phone_number: "5203709111"
      }
    }

    patch :update, params: params, session: { verified: true }
    expect(session[:verified]).to eq(false)
  end
end

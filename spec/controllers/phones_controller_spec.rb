# frozen_string_literal: true

require "rails_helper"
include ApplicationHelper


describe PhonesController, type: :controller do
  it "able to access edit screen with a unverified phone number" do
    user = FactoryBot.create(:user)
    user.phone_verified = false
    user.save
    sign_in user
    get :edit
    expect(response.status).to eq(200)
  end

  it "unable to access edit screen with a verified phone number" do
    user = FactoryBot.create(:user)
    # user.phone_verified = true
    # user.save
    sign_in user
    get :edit
    expect(response).to redirect_to(phone_verify_path)
  end
end

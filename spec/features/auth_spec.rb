# frozen_string_literal: true

require "rails_helper"

describe "Auth Pages", type: :feature do
  it "can load a sign in page" do
    visit "/sign_in/"
    expect(page.status_code).to be 200
  end

  it "can load a sign up page" do
    visit "/users/sign_up/"
    expect(page.status_code).to be 200
  end

  it "can load a reset password page" do
    visit "/users/password/new/"
    expect(page.status_code).to be 200
  end
end

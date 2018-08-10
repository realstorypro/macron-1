# frozen_string_literal: true

require "rails_helper"

describe "Login Flow", type: :feature do
  before do
    visit "/sign_in/"
  end

  it "can't log in wih fake account" do
    fill_in :user_login, with: "hello"
    fill_in :user_password, with: "World"
    find('button.primary').click
    expect(page).to have_content 'Invalid Login'
  end

  it "can log in wih real account" do
    user = FactoryBot.create(:user, :admin)
    fill_in :user_login, with: user.username
    fill_in :user_password, with: user.password
    find('button.primary').click
    expect(page).to_not have_content 'Invalid Login'
  end
end
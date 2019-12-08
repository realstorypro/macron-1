# frozen_string_literal: true

require "rails_helper"

describe "Support Page", type: :feature do
  before(:each) do
    skip "skipping for now"
    sign_in FactoryBot.create(:user, :admin)
    visit "/admin/support/"
  end

  it "can successfully load a page" do
    expect(page.status_code).to be 200
  end
end

# frozen_string_literal: true

require "rails_helper"

include ApplicationHelper
@pages = s("pages")

describe "Support Page Testing", type: :feature do
  before(:each) do
    sign_in FactoryBot.create(:user, :admin)
    visit "/admin/support/"
  end

  it "can successfully load a page" do
    expect(page.status_code).to be 200
  end
end

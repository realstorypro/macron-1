# frozen_string_literal: true

require "rails_helper"

include ApplicationHelper
@pages = s("pages")

@pages.each do |p|
  describe "Testing Page : #{node_name(p).capitalize}", type: :feature do
    before(:each) do
      visit "/#{node_name(p)}"
    end

    it "can successfully load a page" do
      expect(page.status_code).to be 200
    end

    it "has a correct title" do
      expect(page.title).to include node_value(p).title
    end
  end
end

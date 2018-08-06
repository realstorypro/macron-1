# frozen_string_literal: true

require "rails_helper"

describe "Components Admin", type: :feature do
  components = %w(users articles videos discussions podcasts categories tags)

  before(:each) do
    sign_in FactoryBot.create(:user, :admin)
  end

  components.each do |component|
    it "can visit #{component} index page" do
      visit "/admin/#{component}/"
      expect(page.status_code).to be 200
    end

    it "can visit #{component} show page" do
      built_component = FactoryBot.create(component.singularize)
      visit "/admin/#{component}/#{built_component.id}"
      expect(page).to have_content built_component.name
    end

    it "can visit #{component} new page" do
      built_component = FactoryBot.create(component.singularize)
      visit "/admin/#{component}/new"
      expect(page.status_code).to be 200
    end
  end


end

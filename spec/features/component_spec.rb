# frozen_string_literal: true

require "rails_helper"

describe "Components", type: :feature do
  components = %w(articles videos discussions podcasts)

  components.each do |component|
    it "can visit #{component} index" do
      visit "/#{component}/"
      expect(page.status_code).to be 200
    end

    it "can visit #{component} details" do
      built_component = FactoryBot.create(component.singularize)
      visit "/#{component}/#{built_component.category.slug}/#{built_component.slug}"
      expect(page).to have_content built_component.name
    end
  end


end

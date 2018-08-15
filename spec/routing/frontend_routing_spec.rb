# frozen_string_literal: true

require "rails_helper"

include PathHelper

describe "Front End Meta Routing Spec", type: :feature do
  @components = s("components")
  @tests = s("tests").select { |test| test.frontend != nil }

  @tests.each do |test|
    if test.frontend.include?("index")
      it "can visit :: #{test.component} :: index" do
        visit "/#{test.component}/"
        expect(page.status_code).to be 200
      end
    end

    if test.frontend.include?("show")
      it "can visit :: #{test.component} :: show" do
        built_component = FactoryBot.create(test.component.singularize)
        visit "/#{test.component}/#{built_component.category.slug}/#{built_component.slug}"
        expect(page).to have_content built_component.name
      end
    end
  end
end

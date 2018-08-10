# frozen_string_literal: true

require "rails_helper"

include PathHelper

# builds the path
def visit_path(test)
  "/admin/#{test.component}/"
end

describe "Admin Meta Routing Spec", type: :feature do
  @components = s("components")
  @tests = s("tests").select {|test| test.admin != nil}

  before(:all) do
    @admin = FactoryBot.create(:user, :admin)
  end

  before(:each) do
    sign_in @admin
  end

  after(:each) do
    sign_out @admin
  end

  @tests.each do |test|
    if test.admin.include?("index")
      it "can visit :: #{test.component} :: index" do
        visit visit_path(test)
        expect(page.status_code).to be 200
      end
    end

    if test.admin.include?("show")
      it "can visit :: #{test.component} :: show" do
        built_component = FactoryBot.create(test.component.singularize)
        visit ("#{visit_path(test)}#{built_component.id}")
        expect(page).to have_content built_component.name
      end
    end


  end
end

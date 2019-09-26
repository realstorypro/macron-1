# frozen_string_literal: true

require "rails_helper"

include PathHelper

# builds the path
def visit_admin_path(test)
  "/admin/#{test.component}/"
end

describe "Admin Meta Routing Spec", type: :feature do
  @components = s("components")
  @tests = s("tests").select { |test| test.admin != nil }

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
        page.set_rack_session(verified: true)
        visit visit_admin_path(test)
        expect(page.status_code).to be 200
      end
    end

    if test.admin.include?("show")
      it "can visit :: #{test.component} :: show" do
        page.set_rack_session(verified: true)

        # gets the component class, and substitutes class delimitter with underscores
        # in order to get the proper factory name
        component_factory = s("components.#{test.component}.klass").downcase.gsub("::",'_').to_sym

        built_component = FactoryBot.create(component_factory)
        visit ("#{visit_admin_path(test)}#{built_component.id}")
        expect(page).to have_content built_component.name
      end
    end
  end
end

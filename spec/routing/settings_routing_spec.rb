require "rails_helper"

include PathHelper

# builds the path
def visit_path(test)
  return_path = "/admin/#{test.component.gsub(/site_settings_?/, 'settings/')}/"
  return_path.gsub!('theme_','theme/')
end

describe "Settings Meta Routing Spec", type: :feature do
  @components = s("components")
  @tests = s("tests").select { |test| test.admin_settings != nil }

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
    if test.admin_settings.include?("index")
      it "can visit :: #{test.component} :: index" do
        visit visit_path(test)
        expect(page.status_code).to be 200
      end
    end

    if test.admin_settings.include?("show")
      it "can visit :: #{test.component} :: show" do
        built_component = FactoryBot.create(test.component.singularize)
        visit ("#{visit_path(test)}#{built_component.id}")
        expect(page).to have_content built_component.name
      end
    end
  end
end

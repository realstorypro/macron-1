require "rails_helper"

include PathHelper

# builds the path
def visit_admin_settings_path(test)
  return_path = "/admin/#{test.component.gsub(/site_settings_?/, 'settings/')}/"
  return_path.gsub!('theme_','theme/')
end

# returns a pretty setting name
def pretty_name(component)
  "Test #{component.gsub(/site_settings/, 'settings')}".gsub(/settings_?/,"settings ")
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
      it "can visit :: #{pretty_name(test.component)} :: index" do
        visit visit_admin_settings_path(test)
        expect(page.status_code).to be 200
      end
    end

    if test.admin_settings.include?("edit")
      it "can visit :: #{pretty_name(test.component)} :: edit" do
        visit ("#{visit_admin_settings_path(test)}#edit")
        expect(page.status_code).to be 200
      end
    end
  end
end

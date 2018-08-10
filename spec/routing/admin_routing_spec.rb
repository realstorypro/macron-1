# frozen_string_literal: true

require "rails_helper"

include PathHelper

# builds the path
def visit_path(test)
  "/admin/#{test.component.gsub('site_settings','settings')}/"
end


describe "Admin Meta Feature Test", type: :feature do
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
        visit (visit_path(test) + built_component.id)
        expect(page).to have_content built_component.name
      end
    end


  end
end


# Returns the constanized class name
# def build_class(test)
#   test[:klass].constantize
# end
#
# # Builds out an admin user
# def build_admin
#   FactoryBot.create(:user, :admin)
# end
#
# # Creates a list of test factories
# def build_factory(test)
#  FactoryBot.create_list(test[:factory], 20)
# end

# variable used to store the test data
# @testing = []

# def build_test_hash(test, namespace = nil)
#   hash = {}
#   hash[:component] =  test.component
#   hash[:actions] = test.actions
#   hash[:namespace] = namespace
#   # hash[:paths] = build_paths(test.component, namespace, test.actions)
#
#   component = @components[test.component]
#   if component.klass
#     hash[:klass] = component.klass
#     hash[:factory] = component.klass.downcase.singularize.to_sym
#   end
#
#  hash
# end

# tests.each do |test|
#   next unless test.implementation == true
#   next unless test.actions.include?("index") || test.actions.include?("show")
#   @testing << build_test_hash(test, "admin") if test.admin
#   @testing << build_test_hash(test) if test.frontend
# end


# @testing.each do |test|
#   describe "Testing Component: #{(test[:component]).capitalize}", :implementation do
#   before(:all) do
#     @admin = build_admin
#   end
#
#   before(:each) do
#     sign_in @admin
#   end
#
#   after(:each) do
#     sign_out @admin
#   end
#
#   if test[:actions].include? "index"
#     it "can successfully load an index page in :: #{test[:namespace]}" do
#       visit meta_index_path test[:namespace], test[:component]
#       expect(page.status_code).to be 200
#     end
#   end
#
#   if test[:actions].include? "show"
#     it "can successfully load a show page in :: #{test[:namespace]}" do
#       build_factory test
#       last_entry = build_class(test).last
#
#       visit meta_show_path last_entry, test[:namespace], test[:component]
#       expect(page.status_code).to be 200
#     end
#   end
# end
# end

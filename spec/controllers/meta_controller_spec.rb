# frozen_string_literal: true

# rubocop:disable BlockLength

require "rails_helper"

include ApplicationHelper

@components = s("components")
tests = s("tests")

# variable used to store the test data
@testing = []

def admin_test(test)
  hash = build_test_hash test
  hash[:controller] = "Admin::#{test.component.capitalize}Controller"
  @testing << hash
end

def frontend_test(test)
  hash = build_test_hash test
  hash[:controller] = "#{test.component.capitalize}Controller"
  @testing << hash
end

def build_test_hash(test)
  component = @components[test.component]

  rtr = { component: test.component }
  rtr[:actions] = test.actions
  if component.klass
    rtr[:klass] = component.klass
    rtr[:factory] = component.klass.downcase.singularize.to_sym
  end

  rtr
end

def build_class(test)
  test[:klass].constantize
end

def build_admin
  FactoryBot.create(:user, :admin)
end

# Creates a list of test factories
def build_factory(test)
  FactoryBot.create_list(test[:factory], 20)
end

def build_attributes(test)
  FactoryBot.build(test[:factory]).attributes
end

# returns the @entry_class instance from the controller
def entry_class(controller)
  controller.instance_variable_get(:@entry_class)
end

# returns the @entries instance from the controller
def entries(controller)
  controller.instance_variable_get(:@entries)
end

# returns @entry instance from the controller
def entry(controller)
  controller.instance_variable_get(:@entry)
end

# returns singular component name
def comp(test)
  test[:component].to_s.singularize
end

tests.each do |test|
  admin_test(test) if test.admin
  frontend_test(test) if test.frontend
end

@testing.each do |t|
  @controller_class = t[:controller].classify.constantize

  describe @controller_class, type: :controller do
    if t[:actions].include?("index")
      describe "index actions" do
        before(:all) do
          @admin = build_admin
        end

        before(:each) do
          sign_in @admin
          get :index, params: { component: t[:component] }
        end

        after(:each) do
          sign_out @admin
        end

        if t[:klass]
          it "The entry class is properly set." do
            expect(entry_class(controller)).to be build_class(t)
          end

          it "The length of entries is not null" do
            build_factory t
            expect(entries(controller).length).to_not be_nil
          end
        end

        it "The response is 200" do
          expect(response.status).to be 200
        end
      end
    end

    if t[:actions].include?("show")
      describe "show actions" do
        before(:all) do
          @admin = build_admin

          build_factory t
          @last_entry = build_class(t).last
        end

        before(:each) do
          sign_in @admin
          get :show, params: { component: t[:component], id: @last_entry.id }
        end

        after(:each) do
          sign_out @admin
        end

        it "The entry class is properly set." do
          expect(entry_class(controller)).to be build_class(t)
        end

        it "loads a correct entry" do
          expect(entry(controller)).to eq(@last_entry)
        end

        it "The response is 200" do
          expect(response.status).to be 200
        end
      end
    end

    if t[:actions].include?("new")
      describe "new actions" do
        before(:all) do
          @admin = build_admin
        end

        before(:each) do
          sign_in @admin
          get :new, params: { component: t[:component] }
        end

        after(:each) do
          sign_out @admin
        end

        it "The entry class is properly set." do
          expect(entry_class(controller)).to be build_class(t)
        end

        it "creates the correct new class entry" do
          expect(entry(controller)).to be_a_new build_class(t)
        end

        it "The response is 200" do
          expect(response.status).to be 200
        end
      end
    end

    if t[:actions].include?("edit")
      describe "edit actions" do
        before(:all) do
          @admin = build_admin

          build_factory t
          @last_entry = build_class(t).last
        end

        before(:each) do
          sign_in @admin
          get :edit, params: { component: t[:component], id: @last_entry.id }
        end

        after(:each) do
          sign_out @admin
        end

        it "The entry class is properly set." do
          expect(entry_class(controller)).to be build_class(t)
        end

        it "loads a correct entry" do
          expect(entry(controller)).to eq(@last_entry)
        end

        it "The response is 200" do
          expect(response.status).to be 200
        end
      end
    end

    if t[:actions].include?("update")
      describe "valid update actions" do
        before(:all) do
          @admin = build_admin

          build_factory t
          @last_entry = build_class(t).last
        end

        before(:each) do
          sign_in @admin
          params = {
            component: t[:component],
            id: @last_entry.id,
            comp(t) => { name: Faker::Name.name }
          }

          patch :update, params: params
        end

        after(:each) do
          sign_out @admin
        end

        it "The entry class is properly set." do
          expect(entry_class(controller)).to be build_class(t)
        end

        it "loads a correct entry" do
          expect(entry(controller)).to eq(@last_entry)
        end

        it "The response is 204" do
          expect(response.status).to be 204
        end

        it "Receives a success header" do
          expect(response.headers["status"]).to eq "success"
        end
      end
    end

    if t[:actions].include?("update")
      describe "in-valid update actions" do
        before(:all) do
          @admin = build_admin

          build_factory t
          @last_entry = build_class(t).last
        end

        before(:each) do
          sign_in @admin
          params = {
            component: t[:component],
            id: @last_entry.id,
            comp(t) => { name: nil }
          }

          patch :update, params: params
        end

        after(:each) do
          sign_out @admin
        end

        it "The response is 200" do
          expect(response.status).to be 200
        end

        it "Receives an error header" do
          expect(response.headers["status"]).to eq "error"
        end
      end
    end

    if t[:actions].include?("create")
      describe "valid create actions" do
        before(:each) do
          @admin = build_admin

          attrs = build_attributes t
          @params = { component: t[:component] }
          @params[t[:factory]] = attrs
        end

        before(:each) do
          sign_in @admin
          post :create, params: @params
          @last_entry = build_class(t).last
        end

        after(:each) do
          sign_out @admin
        end

        it "The entry class is properly set." do
          expect(entry_class(controller)).to be build_class(t)
        end

        it "loads a correct entry" do
          entry = controller.instance_variable_get(:@entry)
          expect(entry).to eq(@last_entry)
        end

        it "The response is 204" do
          expect(response.status).to be 204
        end

        it "Receives a success header" do
          expect(response.headers["status"]).to eq "success"
        end
      end
    end

    if t[:actions].include?("create")
      describe "in-valid create actions" do
        before(:all) do
          @admin = build_admin

          attrs = build_attributes t
          attrs["name"] = nil
          @params = { component: t[:component] }
          @params[t[:factory]] = attrs
        end

        before(:each) do
          sign_in @admin
          patch :create, params: @params
        end

        after(:each) do
          sign_out @admin
        end

        it "The response is 200" do
          expect(response.status).to be 200
        end

        it "Receives an error header" do
          expect(response.headers["status"]).to eq "error"
        end
      end
    end

    if t[:actions].include?("destroy")
      describe "destroy actions" do
        before(:all) do
          @admin = build_admin
          build_factory t
        end

        after(:each) do
          sign_out @admin
        end

        before(:each) do
          sign_in @admin
          @last_entry = build_class(t).last
          params = {
            component: t[:component],
            id: @last_entry.id
          }

          patch :destroy, params: params
        end

        it "The entry class is properly set." do
          expect(entry_class(controller)).to be build_class(t)
        end

        it "loads a correct entry" do
          expect(entry(controller)).to eq(@last_entry)
        end

        it "destroys an entry" do
          expect(build_class(t).find_by_id(@last_entry.id)).to be_nil
        end

        it "The response is 302" do
          expect(response.status).to be 302
        end

        it "Receives an error header" do
          expect(response.headers["status"]).to eq "success"
        end
      end
    end
  end
end

# rubocop:enable BlockLength

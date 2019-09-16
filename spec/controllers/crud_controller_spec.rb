# frozen_string_literal: true

# rubocop:disable BlockLength

require "rails_helper"
include ApplicationHelper


describe Admin::CrudController, type: :controller do
  @components = s("components")
  @tests = s("tests").select { |test| test.crud != nil }

  def entry_factory(test)
    s("components.#{test.component}.klass").downcase.singularize.to_sym
  end

  def entry_class(test)
    s("components.#{test.component}.klass").constantize
  end

  def controller_class
    controller.instance_variable_get(:@entry_class)
  end

  def controller_entry(controller)
    controller.instance_variable_get(:@entry)
  end

  @tests.each do |test|
    # ~~~~~~~~ INDEX ACTIONS ~~~~~~~~ #

    if test.crud.include?("index")
      describe "index actions for #{test.component}" do
        before(:all) do
          @admin = FactoryBot.create(:user, :admin)
        end

        before(:each) do
          sign_in @admin
          get :index, session: { verified: true }, params: { component: test.component }
        end

        after(:each) do
          sign_out @admin
        end

        it "The entry class is properly set." do
          expect(controller_class).to be entry_class(test)
        end

        it "The length of entries is not null" do
          FactoryBot.create_list(entry_factory(test), 20)
          controller_entries = controller.instance_variable_get(:@entries)
          expect(controller_entries.length).to_not be_nil
        end

        it "The response is 200" do
          expect(response.status).to be 200
        end
      end
    end

    # ~~~~~~~~ SHOW ACTIONS ~~~~~~~~ #

    if test.crud.include?("show")
      describe "show actions for #{test.component}" do
        before(:all) do
          @admin = FactoryBot.create(:user, :admin)
          @last_entry = FactoryBot.create_list(entry_factory(test), 20).last
        end

        before(:each) do
          sign_in @admin
          get :show, session: { verified: true }, params: { component: test.component, id: @last_entry.id }
        end

        after(:each) do
          sign_out @admin
        end

        it "The entry class is properly set." do
          expect(controller_class).to be entry_class(test)
        end

        it "loads a correct entry" do
          expect(controller_entry(controller)).to eq(@last_entry)
        end

        it "The response is 200" do
          expect(response.status).to be 200
        end
      end
    end


    # ~~~~~~~~ NEW ACTIONS ~~~~~~~~ #

    if test.crud.include?("new")
      describe "new actions for #{test.component}" do
        before(:all) do
          @admin = FactoryBot.create(:user, :admin)
        end

        before(:each) do
          sign_in @admin
          get :new, session: { verified: true }, params: { component: test.component }
        end

        after(:each) do
          sign_out @admin
        end

        it "The entry class is properly set." do
          expect(controller_class).to be entry_class(test)
        end

        it "creates the correct new class entry" do
          expect(controller_entry(controller)).to be_a_new entry_class(test)
        end

        it "The response is 200" do
          expect(response.status).to be 200
        end
      end
    end

    # ~~~~~~~~ EDIT ACTIONS ~~~~~~~~ #

    if test.crud.include?("edit")
      describe "edit actions for #{test.component}" do
        before(:all) do
          @admin = FactoryBot.create(:user, :admin)
          @last_entry = FactoryBot.create_list(entry_factory(test), 20).last
        end

        before(:each) do
          sign_in @admin
          get :edit, session: { verified: true }, params: { component: test.component, id: @last_entry.id }
        end

        after(:each) do
          sign_out @admin
        end

        it "The entry class is properly set." do
          expect(controller_class).to be entry_class(test)
        end

        it "loads a correct entry" do
          expect(controller_entry(controller)).to eq(@last_entry)
        end

        it "The response is 200" do
          expect(response.status).to be 200
        end
      end
    end

    # ~~~~~~~~ UPDATE ACTIONS ~~~~~~~~ #

    if test.crud.include?("update")
      describe "valid update actions for #{test.component}" do
        before(:all) do
          @admin = FactoryBot.create(:user, :admin)
          @last_entry = FactoryBot.create_list(entry_factory(test), 20).last
        end

        before(:each) do
          sign_in @admin
          params = {
            component: test.component,
            id: @last_entry.id,
            test.component.to_s.singularize => { name: Faker::Name.name }
          }

          patch :update, params: params, session: { verified: true }
        end

        after(:each) do
          sign_out @admin
        end

        it "The entry class is properly set." do
          expect(controller_class).to be entry_class(test)
        end

        it "loads a correct entry" do
          expect(controller_entry(controller)).to eq(@last_entry)
        end

        it "The response is 302" do
          expect(response.status).to be 302
        end

        it "Receives a success header" do
          expect(response.headers["status"]).to eq "success"
        end
      end
    end

    if test.crud.include?("update")
      describe "invalid update actions for #{test.component}" do
        before(:all) do
          @admin = FactoryBot.create(:user, :admin)
          @last_entry = FactoryBot.create_list(entry_factory(test), 20).last
        end

        before(:each) do
          sign_in @admin
          params = {
              component: test.component,
              id: @last_entry.id,
              test.component.to_s.singularize => { name: nil }
          }

          patch :update, params: params, session: { verified: true }
        end

        after(:each) do
          sign_out @admin
        end

        it "The entry class is properly set." do
          expect(controller_class).to be entry_class(test)
        end

        it "loads a correct entry" do
          expect(controller_entry(controller)).to eq(@last_entry)
        end

        it "The response is 200" do
          expect(response.status).to be 200
        end

        it "Receives a success header" do
          expect(response.headers["status"]).to eq "error"
        end
      end
    end

    # ~~~~~~~~ CREATE ACTIONS ~~~~~~~~ #

    if test.crud.include?("create")
      describe "valid create actions for #{test.component}" do
        before(:each) do
          @admin = FactoryBot.create(:user, :admin)
          factory = FactoryBot.build(entry_factory(test))

          attrs = factory.attributes
          payload = attrs["payload"]
          attrs.delete("payload")
          attrs = attrs.merge(payload) unless payload.nil?

          @params = { component: test.component }
          @params[entry_factory(test)] = attrs
        end

        before(:each) do
          sign_in @admin
          post :create, params: @params, session: { verified: true }
          @last_entry = entry_class(test).last
        end

        after(:each) do
          sign_out @admin
        end

        it "The entry class is properly set." do
          expect(controller_class).to be entry_class(test)
        end

        it "loads a correct entry" do
          expect(controller_entry(controller)).to eq(@last_entry)
        end

        it "The response is 204" do
          expect(response.status).to be 204
        end

        it "Receives a success header" do
          expect(response.headers["status"]).to eq "success"
        end
      end

      describe "in-valid create actions for #{test.component}" do
        before(:each) do
          @admin = FactoryBot.create(:user, :admin)

          attrs = FactoryBot.build(entry_factory(test)).attributes
          payload = attrs["payload"]
          attrs.delete("payload")
          attrs = attrs.merge(payload) unless payload.nil?
          attrs["name"] = nil

          @params = { component: test.component }
          @params[entry_factory(test)] = attrs
        end

        before(:each) do
          sign_in @admin
          post :create, params: @params, session: { verified: true }
          @last_entry = entry_class(test).last
        end

        after(:each) do
          sign_out @admin
        end

        it "The response is 200" do
          expect(response.status).to be 200
        end

        it "Receives a success header" do
          expect(response.headers["status"]).to eq "error"
        end
      end
    end

    # ~~~~~~~~ DELETE ACTIONS ~~~~~~~~ #

    if test.crud.include?("create")
      describe "destroy actions for #{test.component}" do
        before(:all) do
          @admin = FactoryBot.create(:user, :admin)
          FactoryBot.create_list(entry_factory(test), 20)
        end

        after(:each) do
          sign_out @admin
        end

        before(:each) do
          sign_in @admin
          @last_entry = entry_class(test).last
          params = {
            component: test.component,
            id: @last_entry.id
          }

          patch :destroy, params: params, session: { verified: true }
        end

        it "The entry class is properly set." do
          expect(controller_class).to be entry_class(test)
        end

        it "loads a correct entry" do
          expect(controller_entry(controller)).to eq(@last_entry)
        end

        it "destroys an entry" do
          expect(entry_class(test).find_by_id(@last_entry.id)).to be_nil
        end

        it "The response is 302" do
          expect(response.status).to be 302
        end

        it "Receives a success header" do
          expect(response.headers["status"]).to eq "success"
        end
      end
    end
  end
end

# rubocop:enable BlockLength

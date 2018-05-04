# frozen_string_literal: true

# rubocop:disable BlockLength
require "rails_helper"
include SettingsHelper

describe User, type: :model do
  describe "validations" do
    it "must have a unque slug" do
      user = FactoryBot.create(:user, :admin)
      expect(user.slug).to_not be nil
    end

    it "must have a username" do
      user = FactoryBot.create(:user)
      user.username = nil
      expect(user).to_not be_valid
    end
  end

  describe "factories" do
    it "must have a user factory" do
      expect(FactoryBot.create(:user)).to be_valid
    end

    it "must have an admin factory" do
      admin = FactoryBot.create(:user, :admin)
      expect(admin.has_role?(:admin)).to be true
    end
  end

  describe "roles" do
    it "should have set a valid default role" do
      FactoryBot.create(:user)
      last_user = User.last
      default_role = settings("defaults.permissions.new_user.role", fatal_exception: true).to_sym
      expect(last_user.has_role?(default_role)).to eq true
    end

    it "should not be able to set a non existing role" do
      FactoryBot.create(:user)
      last_user = User.last
      expect { last_user.add_role(:nonrole) }.to raise_error(RuntimeError)
    end

    it "should not be able to set an existing role" do
      FactoryBot.create(:user)
      last_user = User.last
      expect { last_user.add_role(:editor) }.not_to raise_error
    end
  end
end
# rubocop:enable BlockLength

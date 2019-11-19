# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require "rails_helper"
include SettingsHelper

describe User, type: :model do
  describe "validations" do
    before :each do
      @user = FactoryBot.create(:user)
    end

    after :each do
      @user.delete
    end

    it "must have a unque slug" do
      expect(@user.slug).to_not be nil
    end

    it "must have a username" do
      @user.username = nil
      expect(@user).to_not be_valid
    end

    it "must have not accept non mobile phone number" do
      skip "not testing for this yet"
      @user.phone_number = "5205792211"
      expect(@user).to_not be_valid
    end

    it "must have not accept non invalid phone numbers" do
      @user.phone_number = "520579221"
      expect(@user).to_not be_valid
    end

    it "must have accept mobile phone number" do
      @user.phone_number = "5203702211"
      expect(@user).to be_valid
    end

    it "must have set phone validated field to false once number has changed" do
      @user.update(phone_number: "5203708241")
      expect(@user.phone_verified).to be false
    end
  end

  describe "factories" do
    before :each do
      @user = FactoryBot.create(:user)
    end

    after :each do
      @user.delete
    end

    it "must have a user factory" do
      expect(@user).to be_valid
    end

    it "must have an admin factory" do
      admin = FactoryBot.create(:user, :admin)
      expect(admin.has_role?(:admin)).to be true
      admin.delete
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

  describe "supporters" do
    it "should have no supporters"  do
      FactoryBot.create(:user)
      first_user = User.first
      expect(first_user.supporters.count).to eq 0
    end

    it "should successfuly add a supporter" do
      FactoryBot.create(:user)
      first_user = User.first
      FactoryBot.create(:user)
      second_user = User.last
      expect { first_user.support(second_user) }.to change { second_user.supporters_count }.by(1)
    end
  end

  describe "new player state" do
    before :all do
      @user = FactoryBot.create(:user, :admin)
    end

    it "returns a state" do
      expect(@user.state).to_not be_nil
    end

    it "returns paths" do
      expect(@user.state.paths).to_not be_nil
    end

    it "paths level should be 1" do
      @user.state.paths.each do |path|
        expect(path.level).to be(1)
      end
    end

    it "the points are set to 0" do
      expect(@user.state.points).to be(0)
    end
  end

  describe "playing points" do
    before :all do
      @user = FactoryBot.create(:user, :admin)
    end

    it "adding points changes the total state points" do
      expect { @user.add_game_points(:scientist, 200) }.to change { @user.state.points }.by(200)
    end

    it "adding points changes the path points" do
      expect { @user.add_game_points(:scientist, 200) }.to change { @user.get_points(:scientist) }.by(200)
    end

    it "subtracting points changes the total state points" do
      expect { @user.subtract_game_points(:scientist, 200) }.to change { @user.state.points }.by(-200)
    end

    it "subtracting points changes the path points" do
      expect { @user.subtract_game_points(:scientist, 200) }.to change { @user.get_points(:scientist) }.by(-200)
    end
  end

  describe "playing with others" do
    before :all do
      @player1 = FactoryBot.create(:user, :admin)
      @player1.regenerate_energy
      @article = FactoryBot.create(:article)
      @player2 = @article.user
    end

    it "can cast a spell and uncasting spells on subject and another player" do
      expect { @player1.cast_spell!(:love, @article) }.to change { @player2.state.points }.by_at_least(1)
    end
  end
end
# rubocop:enable Metrics/BlockLength

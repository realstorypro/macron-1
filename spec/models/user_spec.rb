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

  describe "supporters" do
    it "should have no supporters"  do
      FactoryBot.create(:user)
      first_user = User.first
      # FactoryBot.create(:user)
      # second_user = User.first
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

    it "paths level should be empty" do
      @user.state.paths.each do |path|
        expect(path.level).to be(0)
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
      expect { @user.add_game_points(:shamanism, 200) }.to change { @user.state.points }.by(200)
    end

    it "adding points changes the path points" do
      expect { @user.add_game_points(:shamanism, 200) }.to change { @user.get_points(:shamanism) }.by(200)
    end

    it "subtracting points changes the total state points" do
      expect { @user.subtract_game_points(:shamanism, 200) }.to change { @user.state.points }.by(-200)
    end

    it "subtracting points changes the path points" do
      expect { @user.subtract_game_points(:shamanism, 200) }.to change { @user.get_points(:shamanism) }.by(-200)
    end
  end

  describe "playing with others" do
    before :all do
      @player1 = FactoryBot.create(:user, :admin)
      @article = FactoryBot.create(:article)
      @player2 = @article.user
    end

    it "can cast a spell and uncasting spells on subject and another player" do
      expect { @player1.cast_spell!(:aho, @article) }.to change { @player2.state.points }.by(5)
    end
  end

end
# rubocop:enable BlockLength

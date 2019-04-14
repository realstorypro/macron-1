# frozen_string_literal: true

require "rails_helper"

describe Game::Player, "new player" do
  before :all do
    new_player = FactoryBot.create(:user, :admin)
    @player = Game::Player.new(new_player)
  end

  it "returns a state" do
    expect(@player.state).to_not be_nil
  end

  it "returns paths" do
    expect(@player.state.paths).to_not be_nil
  end

  it "paths level should be empty" do
    @player.state.paths.each do |path|
      expect(path.level).to be(0)
    end
  end

  it "the points are set to 0" do
    expect(@player.state.points).to be(0)
  end
end

describe Game::Player, "playing points" do
  before :all do
    new_player = FactoryBot.create(:user, :admin)
    @player = Game::Player.new(new_player)
  end

  it "adding points changes the total state points" do
    expect { @player.add_points(:shamanism, 200) }.to change { @player.state.points }.by(200)
  end

  it "adding points changes the path points" do
    expect { @player.add_points(:shamanism, 200) }.to change { @player.points(:shamanism) }.by(200)
  end

  it "subtracting points changes the total state points" do
    expect { @player.subtract_points(:shamanism, 200) }.to change { @player.state.points }.by(-200)
  end

  it "subtracting points changes the path points" do
    expect { @player.subtract_points(:shamanism, 200) }.to change { @player.points(:shamanism) }.by(-200)
  end
end

describe Game::Player, "playing with others" do
  before :all do
    player1 = FactoryBot.create(:user, :admin)
    player2 = FactoryBot.create(:user, :admin)
    @player1 = Game::Player.new(player1)
    @player2 = Game::Player.new(player2)
  end

  it "can cast a spell on another player" do
    expect { @player1.cast_spell!(:aho, @player2) }.to change { @player2.state.points }.by(1)

  end
end

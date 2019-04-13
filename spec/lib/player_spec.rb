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


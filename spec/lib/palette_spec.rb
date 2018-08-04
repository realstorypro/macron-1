# frozen_string_literal: true

require "rails_helper"

describe Palette, "default colors" do
  before :all do
    @palette = Palette.new
  end

  it "it should have color properties" do
    expect(@palette.colors).to_not be(nil)
  end

  it "it should have inverted color properties" do
    expect(@palette.colors).to_not be(nil)
  end

  it "it should return 'inverted' if the color is on inverted list" do
    expect(@palette.contrast("red")).to eq("inverted")
  end

  it "it should return 'regular' if the color is on inverted list" do
    expect(@palette.contrast("white")).to eq("regular")
  end
end

describe Palette, "passed in colors" do
  before :all do
    @palette = Palette.new ({
        colors: %w(yellow white blue),
        inverted: %w(yellow)
    })
  end

  it "it should return 'inverted' if the color is on inverted list" do
    expect(@palette.contrast("yellow")).to eq("inverted")
  end

  it "it should return 'regular' if the color is on inverted list" do
    expect(@palette.contrast("blue")).to eq("regular")
  end

  it "it should return the correct color from the color map" do
    expect(@palette.color_value("blue")).to eq("2185D0")
  end
end

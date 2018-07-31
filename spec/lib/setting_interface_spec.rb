# frozen_string_literal: true

require "rails_helper"

describe SettingInterface, "setting interface" do
  before :all do
    @settings = SettingInterface.new ({
        "first": {
          first_one: "one",
          first_two: "two"
        },
        "second": {
            seond_one: "two-one",
            second_two: "two-two"
        },
        "third": "what",
        "fourth": {
            fifth: {
                sixth: "six"
            }
        }
    }.with_indifferent_access)
  end

  it "should return correct base level property" do
    expect(@settings.fetch_setting("third")).to eq("what")
  end

  it "should return correct second level property" do
    expect(@settings.fetch_setting("second.second_two")).to eq("two-two")
  end

  it "should return correct third level property" do
    expect(@settings.fetch_setting("fourth.fifth.sixth")).to eq("six")
  end
end

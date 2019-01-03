# frozen_string_literal: true

require "rails_helper"

describe SiteSettingInterface, "initalized site setting interface" do
  before :all do
    @settings = SiteSettingInterface.instance
  end

  it "the update should not raise error" do
    expect{@settings.update}.to_not raise_error
  end

  it "fetch should return non empty json" do
    expect(@settings.fetch_json).to_not be_nil
  end

  it "should return true after running clear_cache" do
    expect(@settings.clear_cache).to eq(true)
  end
end

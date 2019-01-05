# frozen_string_literal: true

require "rails_helper"

describe SettingProxy, "setting interface" do
  before :all do
    @settings = SettingProxy.instance
  end

  it "it returns correct array value from colors shallow setting" do
    expect(@settings.fetch_settings("colors")).to include("black")
  end

  it "it returns strings from a deeply nested setting" do
    expect(@settings.fetch_settings("views.site_settings_general.new.name.default")).to eq("Logik")
  end

  it "it returns strings from site settings" do
    expect(@settings.fetch_site_settings("general.name")).to eq("Logik")
  end
end

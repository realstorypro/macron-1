# frozen_string_literal: true

require "rails_helper"
require "ostruct"

describe AnalyticsProxy, "proxy without the segment" do
  before :all do
    @proxy = AnalyticsProxy.instance
    @temp_segment = @proxy.segment
    @proxy.segment = nil
  end

  after :all do
    @proxy.segment = @temp_segment
  end

  it "it returns false on identify call" do
    expect(@proxy.identify).to be(false)
  end

  it "it returns false on track call with anonymous user" do
    anonymous_user = OpenStruct.new(id: "123")
    expect(@proxy.track(user: anonymous_user)).to be(false)
  end
end

describe AnalyticsProxy, "proxy with the segment" do
  before :all do
    @user = FactoryBot.create(:user, :admin)
    @proxy = AnalyticsProxy.instance
  end

  it "it returns false if we call identify without user" do
    expect(@proxy.identify).to be(false)
  end

  it "it returns true if we call identify with user" do
    expect(@proxy.identify(@user)).to be(true)
  end

  it "it returns false on track call with user" do
    anonymous_user = OpenStruct.new(id: "123")
    expect(@proxy.track(user: anonymous_user, event: "test")).to be(true)
  end
end
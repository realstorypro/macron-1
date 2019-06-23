# frozen_string_literal: true

require "rails_helper"
require "ostruct"

describe AnalyticsProxy, "proxy without the segment" do
  before :all do
    @proxy = AnalyticsProxy.instance
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

  before(:each) do
    sign_in @user
  end

  after(:each) do
    sign_out @user
  end

  it "it returns false if we call identify without user" do
    expect(@proxy.identify).to be(false)
  end

  it "it returns true if we call identify with user" do
    expect(@proxy.identify(@user)).to be(true)
  end

  it "it returns true on track call with user" do
    skip
    expect(@proxy.track(user: @user, event: "test")).to be(true)
  end

  it "it returns false on track call without user" do
    skip
    expect(@proxy.track(user: nil, event: "test")).to be(false)
  end
end

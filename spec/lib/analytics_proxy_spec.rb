# frozen_string_literal: true

require "rails_helper"

describe AnalyticsProxy, "proxy without the segment" do
  before :all do
    @proxy = AnalyticsProxy.instance
    @proxy.segment = nil
  end

  it "it returns true on identify call" do
    expect(@proxy.identify).to be(true)
  end

  it "it returns true on track call" do
    expect(@proxy.track).to be(true)
  end
end

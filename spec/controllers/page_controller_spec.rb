# frozen_string_literal: true

require "rails_helper"
include ApplicationHelper

describe PageController, type: :controller do
  describe "GET RSS Feed" do
    it "retruns an rss feed" do
        get :feed, format: "rss"
        response.should be_success
        response.should render_template("page/feed")
        response.content_type.should eq("application/rss+xml")
      end
  end
  describe "GET JSON Feed" do
    it "retruns an JSON feed" do
        get :feed, format: "json"
        response.should be_success
        response.should render_template("page/feed")
        response.content_type.should eq("application/json")
      end
  end
end

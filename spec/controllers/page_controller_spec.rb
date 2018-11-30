require "rails_helper"
include ApplicationHelper

describe PageController, type: :controller do
  describe 'GET RSS Feed' do
    it 'retruns an rss feed' do
      get :feed, :format => "rss"
      response.should be_success
      response.should render_template("page/feed")
      response.content_type.should eq("application/rss+xml")
      end
  end
end


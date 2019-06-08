# frozen_string_literal: true

require "rails_helper"
include ApplicationHelper

describe CommentsController, type: :controller do
  describe "GET JSON Feed" do
    it "retruns an JSON comment feed" do
      @article = FactoryBot.create(:article)
      get :index, params: { component: "articles", record_id: @article.id }, format: "json"
      response.should be_success
      response.content_type.should eq("application/json")
    end
  end
end

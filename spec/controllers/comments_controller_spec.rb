# frozen_string_literal: true

require "rails_helper"
include ApplicationHelper

describe CommentsController, type: :controller do
  describe "Reading Comments" do
    before(:each) do
      @article = FactoryBot.create(:article)
    end

    it "retruns an JSON comment feed" do
      get :index, params: { component: "articles", record_id: @article.id }, format: "json"
      response.should be_success
      response.content_type.should eq("application/json")
    end
  end

  describe "Posting Comments" do
    before(:all) do
      @admin = FactoryBot.create(:user, :admin)
    end
    before(:each) do
      @article = FactoryBot.create(:article)
      sign_in @admin
    end

    it "can successfully create a new comment" do
      post :create, session: {verified: true}, params: {
          component: "articles",
          record_id: @article.id,
          comment: { body: "<p>hello world</p>" }

      }
      response.should be_success
    end

    it "errors for an empty body" do
      post :create, session: {verified: true}, params: {
          component: "articles",
          record_id: @article.id,
          comment: { body: "" }

      }
      response.should be_error
    end

    it "can delete an existing comment" do
      post :create, session: {verified: true}, params: {
          component: "articles",
          record_id: @article.id,
          comment: { body: "<p>hello world</p>" }

      }

      last_comment = Comment.last
      post :destroy, params: { record_id: @article.id, id: last_comment.id }

      response.should be_success
    end
  end
end

# frozen_string_literal: true

require "rails_helper"
include ApplicationHelper

describe API::V1::ActivitiesController, type: :controller do
  describe "GET JSON Feed" do
    it "index retruns an JSON feed" do
      get :index, format: "json"
      response.should be_success
      response.should render_template("api/v1/activities/index")
      response.content_type.should eq("application/json")
    end

    it "show retruns an JSON feed" do
      get :show, params: { id: 123 }, format: "json"
      response.should be_success
      response.should render_template("api/v1/activities/show")
      response.content_type.should eq("application/json")
    end
  end
end

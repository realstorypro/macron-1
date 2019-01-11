# frozen_string_literal: true

# rubocop:disable BlockLength

require "rails_helper"

describe HeadlessPolicy, "Headless Policy for logged out users" do
  before :each do
    @current_user = nil
    @policy = Pundit.policy(@current_user, :headless)
  end

  after :each do
    @policy = nil
  end

  it "it fetches an existing role" do
    expect(@policy.user_roles).to include("guest")
  end

  it "it does not fetch any other roles" do
    expect(@policy.user_roles.count).to equal 1
  end

  ## Action Authorizer Works
  it "authorizes allowed actions" do
    expect(@policy.action_authorized?(:index, :articles)).to be true
  end

  it "does not authorize dis-allowed actions" do
    # removing the admin role, now the user is just a member
    expect(@policy.action_authorized?(:update, :articles)).to be false
  end
end

describe HeadlessPolicy, "Headless Policy for logged in users" do
  before :each do
    @current_user = FactoryBot.create(:user, :admin)
    @policy = Pundit.policy(@current_user, :headless)
  end

  after :each do
    @current_user = nil
    @policy = nil
  end

  ## Checking Component
  it "raises an error if component does not exist" do
    expect { @policy.component_enabled?(:undefined) }.to raise_error(RuntimeError)
  end

  it "returns true if component is enabled" do
    expect(@policy.component_enabled?(:articles)).to be true
  end

  it "returns false if component is disabled" do
    expect(@policy.component_enabled?(:dummy)).to be false
  end

  ## Fetching Roles ##
  it "is able to fetch user roles" do
    expect(@policy.user_roles).to include("admin")
  end

  it "it does not fetch non exist roles" do
    expect(@policy.user_roles).to_not include("guest")
  end

  ## Fetching Abilities ##
  it "throws an error if the action isnt mapped to ability" do
    expect { @policy.ability("dance") }.to raise_error(RuntimeError)
  end

  it "is able to fetch an ability" do
    expect(@policy.ability("show")).to be :read
  end

  it "is able to fetch a correct ability" do
    expect(@policy.ability("update")).to_not be :read
  end

  ## Checking Role Capabilities ##
  it "returns false if the permission is not defined" do
    expect(@policy.role_can?(:admin, :read, :dog)).to be false
  end

  it "returns true if the role can do it all" do
    expect(@policy.role_can?(:admin, :all, :articles)).to be true
  end

  it "returns true if the role has an ability" do
    expect(@policy.role_can?(:guest, :read, :articles)).to be true
  end

  it "returns false if the role does not has an ability" do
    expect(@policy.role_can?(:guest, :update, :articles)).to be false
  end

  ## Action Authorizer Works
  it "authorizes allowed actions" do
    expect(@policy.action_authorized?(:index, :articles)).to be true
  end
end

describe HeadlessPolicy, "Headless Policy for logged out users" do
  before :each do
    @current_user = FactoryBot.create(:user)
    @policy = Pundit.policy(@current_user, :headless)
  end

  after :each do
    @current_user = nil
    @policy = nil
  end

  it "does not authorize dis-allowed actions" do
    expect(@policy.action_authorized?(:update, :articles)).to be false
  end
end

# rubocop:enable BlockLength

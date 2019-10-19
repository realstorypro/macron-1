# rubocop:disable Metrics/BlockLength
# rubocop:disable Style/MixinUsage
require "rails_helper"
include SettingsHelper

describe MenuCell, type: "feature" do
  before :all do
  end

  before :each do
    visit "/"
    c = Struct.new(:env)
    @request = c.new
    @request.env = {}
    @request.env["PATH_INFO"] = "/"

    @current_user = FactoryBot.create(:user)
    @policy = Pundit.policy(@current_user, :headless)
    @cell = MenuCell
  end

  after :each do
    @current_user = nil
    @policy = nil
    @cell = nil
  end

  it "it renders a menu link with `item` class" do
    cell_content = @cell.call(nil,
                              menu: settings("menu.legal"),
                              policy: @policy,
                              request: @request).call
    expect(cell_content).to have_selector ".item"
  end

  it "it renders dividers" do
    cell_content = @cell.call(nil,
                              menu: settings("menu.admin"),
                              policy: @policy,
                              show_divider: true,
                              request: @request).call
    expect(cell_content).to have_selector ".divider"
  end

  it "it renders icons" do
    cell_content = @cell.call(nil,
                              menu: settings("menu.legal"),
                              policy: @policy,
                              show_icons: true,
                              request: @request).call
    expect(cell_content).to have_selector ".icon"
  end

  it "it renders correct text" do
    cell_content = @cell.call(nil,
                              menu: settings("menu.legal"),
                              policy: @policy,
                              show_icons: true,
                              request: @request).call
    expect(cell_content).to have_text "Privacy Policy"
  end
end
# rubocop:enable Metrics/BlockLength
# rubocop:enable Style/MixinUsage

# rubocop:disable Metrics/BlockLength
require "rails_helper"

describe Admin::ActionsCell, type: "feature" do
  before :each do
    @actions = []
    @cell = Admin::ActionsCell
  end

  after :each do
    @actions = nil
    @cell = nil
  end

  describe "buttons" do
    it "does not render a cell without permission" do
      @actions << {
        text: "Test Action",
        permission: false
      }

      expect(@cell.call(nil,
                        actions: @actions,
                        show: :buttons)
       .call).to_not have_content("Test Action")
    end

    it "renders with permissions" do
      @actions << {
        text: "Test Action",
        permission: true
      }

      expect(@cell.call(nil,
                        actions: @actions,
                        show: :buttons)
       .call).to have_content("Test Action")
    end

    it "renders an icon" do
      @actions << {
        text: "Test Action",
        icon: "edit",
        permission: true
      }

      expect(@cell.call(nil,
                        actions: @actions,
                        icons: true,
                        show: :buttons)
       .call).to have_css(".icon.edit")
    end

    it "renders a left labeled button" do
      @actions << {
        text: "Test Action",
        icon: "edit",
        permission: true
      }

      expect(@cell.call(nil,
                        actions: @actions,
                        icons: true,
                        labeled: true,
                        show: :buttons)
       .call).to have_css(".left.labeled.icon")
    end

    it "renders a right labeled button" do
      @actions << {
        text: "Test Action",
        icon: "edit",
        permission: true
      }

      expect(@cell.call(nil,
                        actions: @actions,
                        icons: true,
                        icon_position: :right,
                        labeled:
                        true, show: :buttons)
       .call).to have_css(".right.labeled.icon")
    end
  end

  describe "dropdown" do
    it "does not render a cell without permission" do
      @actions << {
        text: "Test Action",
        permission: false
      }

      expect(@cell.call(nil,
                        actions: @actions,
                        show: :dropdown)
       .call).to_not have_content("Test Action")
    end

    it "renders with permissions" do
      @actions << {
        text: "Test Action",
        permission: true
      }

      expect(@cell.call(nil,
                        actions: @actions,
                        show: :dropdown)
       .call).to have_content("Test Action")
    end
  end
end
# rubocop:enable Metrics/BlockLength

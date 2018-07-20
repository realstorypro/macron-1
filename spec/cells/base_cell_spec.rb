# rubocop:disable BlockLength
# rubocop:disable MixinUsage
# rubocop:disable InverseMethods
require "rails_helper"
include SettingsHelper
include CrudHelper

describe Admin::BaseCell, type: "feature" do
  before :each do
    @cell = Admin::BaseCell
  end

  after :each do
    @cell = nil
  end

  describe "helper methods" do
    it "returns association if one exists" do
      fields = settings("views.users.show").reject { |item| item[1].association.nil? }
      expect(@cell.call.association(fields.first)).to_not be(nil)
    end

    it "returns nil if association doesnt exists" do
      fields = settings("views.users.show").reject { |item| !item[1].association.nil? }
      expect(@cell.call.association(fields.first)).to be(nil)
    end

    it "returns scope if one exists" do
      fields = settings("views.defaults.list").reject { |item| item[1].scope.nil? }
      expect(@cell.call.scope(fields.first)).to_not be(nil)
    end

    it "returns nil if scope doesnt exists" do
      fields = settings("views.users.list").reject { |item| !item[1].scope.nil? }
      expect(@cell.call.scope(fields.first)).to be(nil)
    end

    it "returns a field name" do
      fields = settings("views.users.list")
      expect(@cell.call.name(fields.first)).not_to be(nil)
    end
  end

  describe "rendering methods" do
    before :each do
      @article = Article.last
    end

    it "retruns nil when rendering header" do
      fields = settings("views.articles.new").reject { |item| item[1].type != "header" }
      rendering = @cell.call(nil, records: @article).record_value(fields.last)
      expect(rendering).to eq(nil)
    end

    it "returns a string when rendering string" do
      fields = settings("views.articles.new").reject { |item| item[1].type != "string" }
      rendering = @cell.call(nil, records: @article).record_value(fields.last)
      expect(rendering).to be_a(String)
    end

    it 'includes "ago" when rendering a date' do
      fields = settings("views.articles.new").reject { |item| item[1].type != "datepicker" }
      rendering = @cell.call(nil, records: @article).record_value(fields.last)
      expect(rendering.include?("ago")).to eq(true)
    end

    it "renders a medium image" do
      fields = settings("views.articles.new").reject { |item| item[1].type != "image" }
      rendering = @cell.call(nil, records: @article).record_value(fields.last)
      expect(rendering).to have_selector ".small"
    end

    it "applies a label class to a linked list" do
      fields = settings("views.articles.new").reject { |item| item[1].type != "association" }
      rendering = @cell.call(nil, records: @article).record_value(fields.last)
      expect(rendering).to have_selector ".labels"
    end

    it "applies a label class to an unlinked list" do
      fields = settings("views.defaults.list").reject { |item| item[1].type != "unlinked_list" }
      rendering = @cell.call(nil, records: @article).record_value(fields.last)
      expect(rendering).to have_selector ".labels"
    end

    it "renders a color tag" do
      fields = settings("views.categories.show").reject { |item| item[1].type != "color" }
      category = Category.last
      rendering = @cell.call(nil, records: category).record_value(fields.last)
      expect(rendering).to have_selector ".label"
    end
  end
end
# rubocop:enable BlockLength
# rubocop:enable MixinUsage
# rubocop:enable InverseMethods

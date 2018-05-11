# frozen_string_literal: true

require "rails_helper"

# rubocop:disable BlockLength
describe PathHelper, "path helper" do
  before(:each) do
    @component = :articles
  end
  after(:each) do
    @component = nil
  end

  it "returns index path" do
    expect(helper.index_path(nil, @component)).to eq("articles_path")
  end

  it "returns index path with namespace" do
    expect(helper.index_path(:admin, @component)).to eq("admin_articles_path")
  end

  it "returns new path" do
    expect(helper.new_path(nil, @component)).to eq "new_article_path"
  end

  it "returns new path with namespace" do
    expect(helper.new_path(:admin, @component)).to eq "new_admin_article_path"
  end

  it "returns show path" do
    expect(helper.show_path(nil, @component)).to eq "article_path"
  end

  it "returns show path with namespace" do
    expect(helper.show_path(:admin, @component)).to eq "admin_article_path"
  end

  it "returns edit path" do
    expect(helper.edit_path(nil, @component)).to eq "edit_article_path"
  end

  it "returns edit path with namespace" do
    expect(helper.edit_path(:admin, @component)).to eq "edit_admin_article_path"
  end

  it "returns delete path" do
    expect(helper.delete_path(nil, @component)).to eq "article_path"
  end

  it "returns delete path with namespace" do
    expect(helper.delete_path(:admin, @component)).to eq "admin_article_path"
  end
end

describe PathHelper, "meta plular path helper" do
  before(:each) do
    params[:component] = "articles"
    @entry = FactoryBot.create(:article)
  end
  after(:each) do
    params[:component] = nil
    @entry = nil
  end

  it "calls the index path" do
    expect(helper.meta_index_path).to eq "/articles"
  end

  it "calls the new path" do
    expect(helper.meta_new_path).to eq "/articles/new"
  end

  it "calls the show path" do
    expect(helper.meta_show_path(@entry)).to eq "/articles/#{@entry.slug}"
  end

  it "calls the edit path" do
    expect(helper.meta_edit_path(@entry)).to eq "/articles/#{@entry.slug}/edit"
  end

  it "calls the delete path" do
    expect(helper.meta_delete_path(@entry)).to eq "/articles/#{@entry.slug}"
  end
end
# rubocop:enable BlockLength

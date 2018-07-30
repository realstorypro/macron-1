# frozen_string_literal: true

class PageController < ApplicationController
  layout "layouts/client"
  before_action :set_meta_data, except: %i[sitemap home]

  def home
    featured_limit = ss("theme.homepage.featured_items")

    # @featured_options = { item_count: ss(:homepage_featured_items),
    #                       item_order: ss(:homepage_item_order),
    #                       comment_count: ss(:comment_count),
    #                       content_icons: ss(:content_icons),
    #                       overlay_background: ss(:homepage_overlay_background),
    #                       overlay_color: ss(:homepage_overlay_color),
    #                       category_style: ss(:homepage_category_style)
    # }

    # we only want to enforce homepage_featured items if something was selected
    # otherwise the limit is set manually

    if featured_limit == "auto"
      @featured = Entry.joins(category: :color)
                      .where(type: %w(Article Video Podcast))
                      .includes(category: :color).order("published_date desc")
                      .limit(5)
    else
      @featured = Entry.joins(category: :color)
                      .where(type: %w(Article Video Podcast))
                      .includes(category: :color).order("published_date desc")
                      .limit(ss("theme.homepage.featured_items"))
    end

    @discussions = Discussion.joins(category: :color)
                                     .includes(category: :color).order("published_date desc")
                      .limit(ss("theme.homepage.discussion_items"))
  end

  def sitemap
    redirect_to "http://#{ENV['AWS_S3_BUCKET']}.s3.amazonaws.com/sitemaps/sitemap.xml.gz"
  end

  def action_missing(missing_action, *_args, &_block)
    missing_action.to_s unless page_defined? missing_action
    # giving access to m inside define_method
    define_scope_of_class = class << self; self; end
    define_scope_of_class.class_eval do
      define_method missing_action.to_s do |_method_args = {}, &_method_block|
        missing_action.to_s
      end
    end
  end

    private

      def page_defined?(name)
        Settings.pages.each do |page|
          return true if page.to_s == name.to_s
        end
        false
      end

      def set_meta_data
        @page_title = t("seo.pages.#{action_name}.title")
        @page_description = t("seo.pages.#{action_name}.description")
      end
end

# frozen_string_literal: true

class PageController < ApplicationController
  layout "layouts/client"
  before_action :set_meta_data, except: %i[sitemap home]

  def home
    @featured = Entry.joins(category: :color)
                                .where(type: %w(Article Video))
                                .includes(category: :color).order("published_date desc").limit(ss(:homepage_featured_items))
    @discussions = Discussion.joins(category: :color)
                                      .includes(category: :color).order("published_date desc").limit(ss(:homepage_discussion_items))
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

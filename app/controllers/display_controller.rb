# frozen_string_literal: true

class DisplayController < MetaController
  before_action :entry_class
  before_action :fetch_categories, only: [:index]
  before_action :set_index_seo_meta, only: [:index]
  before_action :set_show_seo_meta, :set_twitter_meta, :set_og_meta, :set_article_meta, only: [:show]
  after_action :record_view, only: [:show]
  helper_method :index_path, :show_path
  layout "layouts/client"

  def index
    @entries = if params[:category]
      entry_class.joins(:category)
                 .where(categories: { slug: params[:category] })
                 .order("published_date desc")
                 .page params[:page]
    else
      entry_class.all.order("published_date desc").page params[:page]
    end
    authorize @entries
  end

    private

      def record_view
        ahoy.track "Viewed Content",
                   type: component_name.downcase.singularize,
                   id: @entry.id,
                   name: @entry.name,
                   slug: @entry.slug,
                   category: @entry.category.name,
                   tags: @entry.tags.collect(&:name)

        return unless user_signed_in?

        @analytics.track(
          user_id: current_user.id,
          event: "Viewed Content",
          properties: {
            type: component_name.downcase.singularize,
            id: @entry.id,
            name: @entry.name,
            slug: @entry.slug,
            category: @entry.category.name,
            tags: @entry.tags.collect(&:name)
          }
        )
      end

      def fetch_categories
        @categories = Category.joins(params[:component].downcase.pluralize.to_sym).distinct(:id).order(:name)
      end

      def set_index_seo_meta
        @page_title = if params[:category]
          "#{params[:category].singularize.capitalize} #{t("seo.components.#{params[:component]}.title")}"
        else
          t("seo.components.#{params[:component]}.title")
        end
        @page_description = t("seo.components.#{params[:component]}.description")
      end

      # TODO
      # ensure that author is properly populated
      # ensure that the _ for the image isn't causing issues
      def set_show_seo_meta
        set_meta_tags title: @entry.long_title,
                      description: @entry.description,
                      keywords: @entry.tags.map(&:name),
                      article: {
                        section: @entry.category.name,
                        author: ss(:facebook),
                        tag: @entry.tags.map(&:name),
                        published_time: @entry.published_date,
                        modified_time: @entry.updated_at
                      }
      end

      def set_twitter_meta
        set_meta_tags twitter: {
          card: "summary_large_image",
          title: @entry.long_title,
          description: @entry.description,
          image: {
            _: @entry.landscape_image,
            alt: @entry.image_alt
          }
        }
      end

      def set_og_meta
        set_meta_tags og: {
          title: @entry.long_title,
          type: "article",
          description: @entry.description,
          url: request.original_url,
          image: {
            _: @entry.landscape_image,
            alt: @entry.image_alt
          }
        }
      end

      # TODO
      # ensure that author is properly populated
      def set_article_meta
        set_meta_tags article: {
          section: @entry.category.name,
          author: ss(:facebook),
          tag: @entry.tags.map(&:name),
          published_time: @entry.published_date,
          modified_time: @entry.updated_at
        }
      end
end

# frozen_string_literal: true

class DisplayController < MetaController
  before_action :fetch_categories, only: [:index]
  before_action :set_index_seo_meta, only: [:index]
  before_action :find_related_content, only: [:show]
  before_action :find_related_promo, only: [:show]
  before_action :set_show_seo_meta, :set_twitter_meta, :set_og_meta, :set_article_meta, only: [:show]
  after_action :track_view, only: [:show]
  after_action :track_promo, only: [:show]
  after_action :store_location, only: %i[index show]
  helper_method :index_path, :show_path
  layout "layouts/client"

  def index
    @entries = if params[:category]
      component.klass.published.joins(:category)
                  .where(categories: { slug: params[:category] })
                  .order("published_date desc")
                  .page params[:page]
    else
      component.klass.all.published.order("published_date desc").page params[:page]
    end
    authorize @entries
  end

  def show
    # caches the show content for 30 minutes
    expires_in 30.minutes
    authorize @entry
  end

  private
    def find_related_promo
      @promo = Tag.find_by_id(@entry.tags.map(&:id))
                 &.promotions&.order(Arel.sql("random()"))&.limit(1)
      @promo = Promotion.order(Arel.sql("random()")).limit(1) if @promo.blank?
    end


    def find_related_content
      taggings = Tagging.where(tag_id: @entry.tags.map(&:id), taggable_type: %w(Article Video Discussion Podcast Event))
                        .where.not(taggable_id: @entry.id)
      content_ids = taggings.map(&:taggable_id)
      @related_content = Entry.published.where(id: content_ids)
      @related_content = @related_content.order(Arel.sql("random()")).limit(8)

      # look up via a category if no tags are found
      if @related_content.blank?
        @related_content = Entry.where(category: @entry.category).order(Arel.sql("random()")).limit(4)
      end
    end

    def track_view
      track(
        event: "Viewed Content",
        props: {
            type: component.name.downcase.singularize,
            id: @entry.id,
            name: @entry.name,
            slug: @entry.slug,
            category: @entry.category.name,
            tags: @entry.tags.collect(&:name)
        }
      )
    end

    def track_promo
      return true if @promo.length == 0
      track(
        event: "Promo Viewed",
        props: {
          id: @promo.last.id,
          name: @promo.last.name,
        }
      )
    end

    def store_location
      session[:current_location] = request.fullpath
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

    def set_show_seo_meta
      set_meta_tags title: @entry.name,
                    description: @entry.description,
                    keywords: @entry.tags.map(&:name),
                    article: {
                      section: @entry.category.name,
                      author: @entry.user.profile.full_name,
                      tag: @entry.tags.map(&:name),
                      published_time: @entry.published_date,
                      modified_time: @entry.updated_at
                    }
    end

    def set_twitter_meta
      set_meta_tags twitter: {
        card: "summary_large_image",
        title: @entry.name,
        description: @entry.description,
        image: {
          _: (@entry.landscape_image if @entry.respond_to?(:landscape_image)),
          alt: (@entry.image_alt if @entry.respond_to?(:image_alt))
        }
      }
    end

    def set_og_meta
      set_meta_tags og: {
        title: @entry.name,
        type: "article",
        description: @entry.description,
        url: request.original_url,
        image: {
          _: (@entry.landscape_image if @entry.respond_to?(:landscape_image)),
          alt: (@entry.image_alt if @entry.respond_to?(:image_alt))
        }
      }
    end

    def set_article_meta
      set_meta_tags article: {
        section: @entry.category.name,
        author: @entry.user.profile.full_name,
        tag: @entry.tags.map(&:name),
        published_time: @entry.published_date,
        modified_time: @entry.updated_at
      }
    end
end

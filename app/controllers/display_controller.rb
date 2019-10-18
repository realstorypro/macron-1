# frozen_string_literal: true

class DisplayController < MetaController
  before_action :fetch_categories, only: [:index]
  before_action :set_index_seo_meta, only: [:index]
  before_action :find_related_content, only: [:show]
  before_action :find_related_promo, only: [:show]
  before_action :set_show_seo_meta, :set_twitter_meta, :set_og_meta, :set_article_meta, only: [:show]
  before_action :tracking_props, only: [:show]
  before_action :tracking_promo_props, only: [:show]
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
    @amped = true if component.amped?

    # used for breadcrumb logic generation
    @breadcrumbs_displayed = false
    @previous_element = nil

    # oversized elemnent classes
    @oversized_elements = %w(oversized header colorblock video)
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

    def tracking_props
      @tracking_props = {
          type: component.name.downcase.singularize,
          id: @entry.id,
          name: @entry.name,
          slug: @entry.slug,
          category: @entry.category.name,
          tags: @entry.tags.collect(&:name)
      }
    end

    def tracking_promo_props
      return true unless @promo.count > 0
      @promo_tracking_props = {
          id: @promo.last.id,
          name: @promo.last.name,
          tags: @promo.last.tags.collect(&:name),
          entry_id: @entry.id
      }
    end

    def store_location
      return true if request.env["HTTP_TURBOLINKS_REFERRER"].present?
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
          _: (@entry.social_image if @entry.respond_to?(:social_image)),
          alt: (@entry.social_alt if @entry.respond_to?(:social_alt))
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
          _: (@entry.social_image if @entry.respond_to?(:social_image)),
          alt: (@entry.social_alt if @entry.respond_to?(:social_alt))
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

# frozen_string_literal: true

module Widget
  class HomepageCell < BaseCell
    cache :show do
      @model.cache_key + Digest::MD5.hexdigest(options[:site_settings].to_s)
    end

    def show
      size = item_count
      if item_count == "auto" || item_count.nil?
        size = @model.count
      else
        size = @model.count if @model.count < item_count.to_i
      end

      render "#{size}_items"
    end

    def widget_item(model, options = {})
      defaults = { image: "card", description: true, size: "" }
      options = defaults.merge(options)

      @item = model
      @size = options[:size]
      @description = options[:description]
      @image = options[:image]

      render :widget_item
    end

    def show_icon(item)
      if item.type == "Article"
        raw("#{icon('newspaper outline')}")
      elsif item.type == "Video"
        raw("#{icon('video')}")
      elsif item.type == "Podcast"
        raw("#{icon('podcast')}")
      end
    end

    def show_link(item)
      if item.type == "Article"
        url_helpers.article_details_path(item.category.slug, item.slug)
      elsif item.type == "Video"
        url_helpers.video_details_path(item.category.slug, item.slug)
      elsif item.type == "Podcast"
        url_helpers.podcast_details_path(item.category.slug, item.slug)
      end
    end

    def subheader_class
      if category_style == "divided"
        "sub dividing #{@item.category.color.name} #{inverted?(overlay_color)}"
      elsif category_style == "white boxed"
        if @item.category.color.name == "white"
          "sub boxed whited black"
        else
          "sub boxed whited #{@item.category.color.name}"
        end
      elsif category_style == "black boxed"
        if @item.category.color.name == "black"
          "sub boxed blacked white"
        else
          "sub boxed blacked #{@item.category.color.name} inverted"
        end
      else
        "sub #{@item.category.color.name} #{inverted?(overlay_color)}"
      end
    end

    # shortcut for accessing position
    def item_count
      ss("theme.homepage.featured_items")
    end

    def overlay_color
      ss("theme.homepage.overlay_color")
    end

    def overlay_background
      ss("theme.homepage.overlay_background")
    end

    def category_style
      ss("theme.homepage.category_style")
    end

    def item_order
      "computer #{ss("theme.homepage.item_order")}"
    end

    # shortcut for content icons
    def content_icons
      ss("theme.homepage.content_icons")
    end

    # shortcut for comment count
    def comment_count
      ss("theme.homepage.comment_count")
    end
  end
end

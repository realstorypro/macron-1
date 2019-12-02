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
        raw("#{icon('newspaper outline large')}")
      elsif item.type == "Video"
        raw("#{icon('video large')}")
      end
    end

    def show_link(item)
      if item.type == "Article"
        url_helpers.article_details_path(item.category.slug, item.slug)
      elsif item.type == "Video"
        url_helpers.video_details_path(item.category.slug, item.slug)
      end
    end

    def subheader_class
      if category_style == "divided"
        "sub dividing #{@item.category.color.name} #{palette.contrast(overlay_color)}"
      elsif category_style == "white boxed"
        "sub boxed whited black"
      elsif category_style == "black boxed"
        "sub boxed blacked white"
      else
        "sub #{@item.category.color.name} #{palette.contrast(overlay_color)}"
      end
    end

    def image_class
      return "fixed background" if image_style == "fixed"
      nil
    end

    def palette
      Palette.new
    end

    # theme settin shortcuts
    def item_count
      ss("theme.homepage.featured_items")
    end

    def overlay_color
      ss("theme.homepage.overlay_color")
    end

    def overlay_background
      #ss("theme.homepage.overlay_background")
      "normal"
    end

    def image_style
      #ss("theme.homepage.image_style")
      "normal"
    end

    def category_style
      ss("theme.homepage.category_style")
    end

    def item_order
      "computer #{ss("theme.homepage.item_order")}"
    end

    def content_icons
      ss("theme.homepage.content_icons")
    end

    def comment_count
      ss("theme.homepage.comment_count")
    end
  end
end

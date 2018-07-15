module Widget
  class HomepageCell < Cell::ViewModel
    include ApplicationHelper
    include DcUi::Helpers

    delegate :url_helpers, to: "Rails.main_app.routes"

    def show
      size = item_count
      if item_count == 'auto'
        size = @model.count
      else
        size = @model.count if @model.count < item_count.to_i
      end
      render "#{size}_items"
    end

    def widget_item(model, size='', description=true, image='card')
      @item = model
      @size = size
      @description = description
      @image = image

      render :widget_item
    end

    def show_icon(item)
      if item.type == 'Article'
        raw("#{icon('newspaper outline')}")
      elsif item.type == 'Video'
        raw("#{icon('video')}")
      end
    end

    def show_link(item)
      if item.type == 'Article'
        url_helpers.article_details_path(item.category.slug, item.slug)
      elsif item.type == 'Video'
        url_helpers.video_details_path(item.category.slug, item.slug)
      end
    end

    # shortcut for accessing position
    def item_count
      options[:item_count]
    end
  end
end

# frozen_string_literal: true

module FooterHelper
  def footer_class
    render_footer_class(ss("theme.footer.color"))
  end

  def footer_item_class
    render_footer_item_class(ss("theme.footer.color"))
  end

  def footer_item_order
    return "computer reversed" if ss("theme.footer.item_order") == "reversed"
    nil
  end

  def footer_copyright_order
    return "right aligned" if ss("theme.footer.item_order") == "reversed"
    "left aligned"
  end

  def footer_icon_order
    return "left aligned" if ss("theme.footer.item_order") == "reversed"
    "right aligned"
  end

  def footer_reversed?
    (ss("theme.footer.item_order") == "reversed") ? true : false
  end

  def footer_icon
    palette = Palette.new
    if palette.contrast(ss("theme.footer.color")) == 'inverted'
      ss('theme.branding.inverted_icon')
    else
      ss('theme.branding.icon')
    end
  end

  private
    def render_footer_class(footer_color)
      palette = Palette.new

      rendering =  ActiveSupport::SafeBuffer.new
      rendering << " #{palette.contrast(footer_color)}"
      rendering << " #{footer_color}"
      rendering
    end

    def render_footer_item_class(footer_color)
      palette = Palette.new

      rendering =  ActiveSupport::SafeBuffer.new
      rendering << " #{palette.contrast(footer_color)}"
      rendering
    end
end

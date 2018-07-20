# frozen_string_literal: true

module FooterHelper
  include ColorHelper

  def footer_class
    render_footer_class(ss(:footer_color))
  end

  def footer_item_class
    render_footer_item_class(ss(:footer_color))
  end

  def footer_item_order
    return "computer reversed" if ss("footer_item_order") == "reversed"
    nil
  end

  def footer_reversed?
    (ss("footer_item_order") == "reversed") ? true : false
  end

  def footer_cta_class

  end

  private

  def render_footer_class(footer_color, options={})
    defaults = { }
    options = defaults.merge(options)

    rendering =  ActiveSupport::SafeBuffer.new
    rendering << " #{inverted?(footer_color)}"
    rendering << " #{footer_color}"
    rendering
  end

  def render_footer_item_class(footer_color, options={})
    defaults = { }
    options = defaults.merge(options)

    rendering =  ActiveSupport::SafeBuffer.new
    rendering << " #{inverted?(footer_color)}"
    rendering
  end

end

# frozen_string_literal: true

module Widget
  class NewsletterCell < BaseCell
    private

      def email
        return options[:current_user].email if options[:current_user]
        ""
      end

      def button_color
        return_class = rendering = ActiveSupport::SafeBuffer.new
        return_class << ss("theme.footer.button_color")
        return_class << " #{ss("theme.footer.button_style")}"
        return_class
      end
  end
end

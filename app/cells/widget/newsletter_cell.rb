# frozen_string_literal: true

module Widget
  class NewsletterCell < BaseCell
    private

      def email
        return options[:current_user].email if options[:current_user]
        ""
      end

      def button_color
        options[:button_color]
      end
  end
end

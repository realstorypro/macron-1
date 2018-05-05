  module Widget
    class FilterCell < BaseCell
      def categories
        options[:categories]
      end

      def active_category
        options[:active_category]
      end
    end
  end

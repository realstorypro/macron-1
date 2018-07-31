module Admin
  class ListCell < AdminBaseCell
    def show
      render
    end

    # renders table header
    def header
      render
    end

    # renders table rows
    def rows
      content = ""

      options[:records].each do |record|
        content.concat(row(record))
      end

      content.html_safe
    end

    # renders table row
    def row(row)
      render(locals: { row: row })
    end

    private

      # makes fields easily accessable by the view
      def fields
        options[:fields]
      end

      # renders the show link by using the model name
      def show_link(options = {})
        model = model_name(options)
        link_to(options[:name], url_helpers.send("admin_#{model}_path", options[:model].id))
      end

      def model_name(options = {})
        model_name = options[:model].class.to_s.underscore.singularize
        model_name
      end
  end
end

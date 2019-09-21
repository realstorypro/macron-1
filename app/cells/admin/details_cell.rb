# frozen_string_literal: true

module Admin
  class DetailsCell < AdminBaseCell
    def show
      rows
    end

    def rows
      @header_locations = []
      @number_of_fields = 0
      options[:fields].each_with_index do |field, index|
        @header_locations << index if field_type(field) == "header"
        @number_of_fields+=1
      end

      if @header_locations.count > 0
        render "tabbed_details"
      else
        render "simple_details"
      end
    end

    def row(field)
      render(locals: { field: field })
    end

    def render_table(index)
      number_of_headers = @header_locations.length
      header_position = @header_locations.find_index(index-1)

      @from = @header_locations[header_position]

      if (number_of_headers - 1) == header_position
        @to = @number_of_fields
      else
        @to = @header_locations[header_position+1]
      end

      render
    end


    def current_user
      options[:user]
    end
  end
end

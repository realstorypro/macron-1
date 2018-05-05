module Admin
  class DetailsCell < BaseCell
    def show
      rows
    end

    def rows
      render
    end

    def row(field)
      render(locals: { field: field })
    end
  end
end

# frozen_string_literal: true

module Admin
  class DetailsCell < AdminBaseCell
    def show
      rows
    end

    def rows
      render
    end

    def row(field)
      render(locals: { field: field })
    end

    def current_user
      options[:user]
    end
  end
end

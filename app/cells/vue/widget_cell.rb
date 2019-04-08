# frozen_string_literal: true

module Vue
  class WidgetCell < Cell::ViewModel
    include DcUi::Helpers

    def show
      render :wrapper
    end

    def id
      uuid ||= Random.new.rand(100)
      name.gsub(' ','_') + uuid.to_s
    end

    def name
      options[:name]
    end

    def data
      options[:data]
    end
  end
end

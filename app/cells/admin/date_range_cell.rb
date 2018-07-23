module Admin
  class DateRangeCell < Cell::ViewModel
    include ApplicationHelper
    include DcUi::Helpers

    def start_date
     options[:start_date].strftime('%m/%d/%Y')
    end

    def end_date
      options[:end_date].strftime('%m/%d/%Y')
    end
  end
end

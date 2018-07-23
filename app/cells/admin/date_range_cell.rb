# frozen_string_literal: true

module Admin
  class DateRangeCell < Cell::ViewModel
    include ApplicationHelper
    include DcUi::Helpers

    def start_date
      options[:start_date].strftime("%m/%d/%Y")
    end

    def end_date
      options[:end_date].strftime("%m/%d/%Y")
    end

    # we're overwriting rails helper here to pull from the passed in site settings
    def site_setting(name)
      options[:site_settings]["payload"][name.to_s]
    end
  end
end

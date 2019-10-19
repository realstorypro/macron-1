# frozen_string_literal: true

# rubocop:disable Style/DateTime
require_dependency "application_controller"

module Admin
  class DashboardController < ApplicationController
    include AdminAccess
    semantic_breadcrumb "Dashboard", :admin_dashboard_index_path
    layout "layouts/admin"

    def index
      @start_date = Date.strptime(params["start"], "%m/%d/%Y") if params["start"]
      @end_date = Date.strptime(params["end"], "%m/%d/%Y") if params["end"]

      @end_date = Date.today.at_end_of_month if @end_date.nil?
      @start_date = Date.today.at_beginning_of_month if @start_date.nil?

      @date_range = (@end_date - @start_date).to_i

      @previous_start_date = @start_date - @date_range
      @previous_end_date = @end_date - @date_range


      @visitors_this_month = Ahoy::Visit.where(started_at: @start_date..@end_date).count
      @previous_visitors_this_month = Ahoy::Visit.where(started_at: @previous_start_date..@previous_end_date).count

      # Graph Start

      @visitors_this_month_grouped = Ahoy::Visit
                                     .where(started_at: @start_date..@end_date)
                                     .group_by_day("started_at").count

      visitor_last_month_trend = Ahoy::Visit
                                     .where(started_at: @start_date..@end_date)
                                     .group_by_day("started_at").count

      @total_visitors_last_month = []
      visitor_last_month_trend.each do |visitor|
        @total_visitors_last_month << [ visitor[0], (@previous_visitors_this_month / @date_range).round(0) ]
      end

      # Graph End

      @new_users = User.where(created_at: @start_date..@end_date).count
      @previous_new_users = User.where(created_at: @previous_start_date..@previous_end_date).count

      @new_comments = Comment.where(created_at: @start_date..@end_date).count
      @previous_new_comments = Comment.where(created_at: @previous_start_date..@previous_end_date).count

      @new_comments_grouped = Comment
                              .where(created_at: @start_date..@end_date)
                              .group_by_day("created_at").count

      @new_clicks = Ahoy::Event.where(name: "Clicked Link", time: @start_date..@end_date).count
      @previous_new_clicks = Ahoy::Event.where(name: "Clicked Link",
                                               time: @previous_start_date..@previous_end_date).count


      @subscriptions_created = Ahoy::Event
                         .where(name: "Subscription Created", time: @start_date..@end_date).count

      @previous_subscriptions_created = Ahoy::Event
                                   .where(name: "Subscription Created",
                                          time: @previous_start_date..@previous_end_date).count


      # Conversion Calculations
      @visitors_to_users = @new_users / @visitors_this_month.to_f
      @previous_visitors_to_users = @previous_new_users / @previous_visitors_this_month.to_f

      @visitors_to_comment = @new_comments / @visitors_this_month.to_f
      @previous_visitors_to_comment = @previous_new_comments / @previous_visitors_this_month.to_f

      @visitors_to_subscriber = @subscriptions_created / @visitors_this_month.to_f
      @previous_visitors_to_subscriber = @previous_subscriptions_created / @previous_visitors_this_month.to_f

      @visitors_to_click = @new_clicks / @visitors_this_month.to_f
      @previous_visitors_to_click = @previous_new_clicks / @previous_visitors_this_month.to_f
    end
  end
end

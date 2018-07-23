# frozen_string_literal: true

# rubocop:disable DateTime
require_dependency "application_controller"

module Admin
  class DashboardController < ApplicationController
    include AdminAccess
    semantic_breadcrumb "Dashboard", :admin_dashboard_index_path
    layout "layouts/admin"

    def index
      @start_date = Date.strptime(params["start"], '%m/%d/%Y') if params["start"]
      @start_date = DateTime.now if @start_date.nil?

      @end_date = Date.strptime(params["end"], '%m/%d/%Y') if params["end"]
      @end_date = Date.today.at_beginning_of_month if @end_date.nil?

      @date_range = (@end_date - @start_date).to_i

      @previous_start_date = @start_date - @date_range
      @previous_end_date = @end_date - @date_range


      @visitors_this_month = Ahoy::Visit.where(started_at: @start_date..@end_date).count
      @previous_visitors_this_month = Ahoy::Visit.where(started_at: @previous_start_date..@previous_end_date).count

      @visitors_this_month_grouped = Ahoy::Visit
                                     .where(started_at: @start_date..@end_date)
                                     .group_by_day("started_at").count

      @new_users = User.where(created_at: @start_date..@end_date).count
      @previous_new_users = User.where(created_at: @previous_start_date..@previous_end_date).count

      @new_comments = Comment.where(created_at: @start_date..@end_date).count
      @previous_new_comments = Comment.where(created_at: @previous_start_date..@previous_end_date).count

      @new_comments_grouped = Comment
                              .where(created_at: @start_date..@end_date)
                              .group_by_day("created_at").count

      @new_clicks = Ahoy::Event.where(name: "Clicked Link", time: @start_date..@end_date).count

      @article_views = Ahoy::Event
                       .where(name: "Viewed Content", time: @start_date..@end_date)
                       .where_props(type: "article").count

      @discussion_views = Ahoy::Event
                          .where(name: "Viewed Content", time: @start_date..@end_date)
                          .where_props(type: "discussion").count

      @video_views = Ahoy::Event
                     .where(name: "Viewed Content", time: @start_date..@end_date)
                     .where_props(type: "video").count

      @subscriptions_created = Ahoy::Event
                         .where(name: "Subscription Created", time: @start_date..@end_date).count

      @previous_subscriptions_created = Ahoy::Event
                                   .where(name: "Subscription Created", time: @previous_start_date..@previous_end_date).count


      # Conversion Calculations
      @visitors_to_users = @new_users / @visitors_this_month.to_f
      @visitors_to_comment = @new_comments / @visitors_this_month.to_f
      @visitors_to_subscriber = @subscriptions_created / @visitors_this_month.to_f
      @visitors_to_click = @new_clicks / @visitors_this_month.to_f
    end
  end
end

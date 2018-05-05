# frozen_string_literal: true

# rubocop:disable DateTime
require_dependency "application_controller"

module Admin
  class DashboardController < ApplicationController
    semantic_breadcrumb "Dashboard", :admin_dashboard_index_path
    layout "layouts/admin"

    def index
      @date_start = DateTime.now
      @date_end = Date.today.at_beginning_of_month

      @visitors_this_month = Ahoy::Visit.where(started_at: @date_end..@date_start).count

      @visitors_this_month_grouped = Ahoy::Visit
                                     .where(started_at: @date_end..@date_start)
                                     .group_by_day("started_at").count

      @new_users = User
                   .where(created_at: @date_end..@date_start).count

      @new_comments = Comment.where(created_at: @date_end..@date_start).count

      @new_comments_grouped = Comment
                              .where(created_at: @date_end..@date_start)
                              .group_by_day("created_at").count

      @new_clicks = Ahoy::Event.where(name: "Clicked Link", time: @date_end..@date_start).count

      @article_views = Ahoy::Event
                       .where(name: "Viewed Content", time: @date_end..@date_start)
                       .where_props(type: "article").count

      @discussion_views = Ahoy::Event
                          .where(name: "Viewed Content", time: @date_end..@date_start)
                          .where_props(type: "discussion").count

      @video_views = Ahoy::Event
                     .where(name: "Viewed Content", time: @date_end..@date_start)
                     .where_props(type: "video").count
    end
  end
end

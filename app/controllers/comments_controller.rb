# frozen_string_literal: true

class CommentsController < ApplicationController
  include SettingsHelper
  include PathHelper

  before_action :find_commentable, only: %i[index create destroy]

  def index
    authorize @comments = @commentable.comments.all.order("created_at")
  end

  def create
    @comment = @commentable.comments.new comment_params
    @comment.user = current_user
    authorize @comment

    render status: 500, json: { notice: "unable to add record" } unless @comment.save

    track(
      event: "Left Comment",
      props: {
        type: params[:component].singularize,
        id: @comment.id, slug: params[:record_id],
        entry_id: @commentable.id
      }
    )
  end

  def destroy
    authorize comment = @commentable.comments.find(params[:id])
    comment.destroy
    render status: 200, json: { notice: "comment successfully deleted" }
  end

    private
      def comment_params
        params.require(:comment).permit(:body)
      end

      def find_commentable
        @commentable = if slugged?(entry_class)
          entry_class.friendly.find(params[:record_id])
        else
          entry_class.find(params[:record_id])
        end
      end

      # returns the entry class
      def entry_class
        @entry_class ||= settings("components.#{params[:component]}.klass", fatal_exception: true).classify.constantize
      end

      # checks if the entry has a slug
      def slugged?(entry)
        entry.column_names.include? "slug"
      end
end

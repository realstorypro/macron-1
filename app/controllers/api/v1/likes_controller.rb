# frozen_string_literal: true

class API::V1::LikesController < ApplicationController
  before_action :find_likeable, only: %i[add remove]

  # returns likes for content type for current user
  def index
  end

  def add
    current_user.like! @likeable
    like = Like.where(liker: current_user, likeable: @likeable).last

    #like.create_activity key: 'like_created', owner: current_user

    render json: @likeable
  end

  def remove
    # get rid of like & activity

    likes = Like.where(liker: current_user, likeable: @likeable)
    # likes.each do |like|
    #   PublicActivity::Activity.where(trackable: like, owner: current_user ).first.destroy
    #   like.destroy
    # end

    current_user.unlike! @likeable

    return head 200
  end

  private

    # returns the likeable entry
    def find_likeable
      @likeable = if slugged?(entry_class)
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

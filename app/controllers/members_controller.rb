# frozen_string_literal: true

# handles the display of the article model
class MembersController < Genesis::DisplayController
  layout "genesis/layouts/client"
  before_action :preload_entry, only: [:show]
  before_action :set_show_seo_meta, :set_twitter_meta, :set_og_meta, :set_article_meta, only: [:show]

  def index
    @entries = Genesis::User.all.includes(:profile).order(:username).page params[:page]
  end

  def show
    @editable = false
  end

  private

    def preload_entry
      @member = Genesis::User.joins(:profile).friendly.find(params[:id])
      @comments = Genesis::Comment.where(user_id: @member.id).order("created_at desc")

      article_comments = Genesis::Comment.where(user_id: @member.id, commentable_type: "Genesis::Article")
      article_comments = article_comments.select(:commentable_id).distinct.pluck(:commentable_id)
      @commented_articles = Genesis::Article.joins(:category).find(article_comments)

      discussion_comments = Genesis::Comment.where(user_id: @member.id, commentable_type: "Genesis::Discussion")
      discussion_comments = discussion_comments.select(:commentable_id).distinct.pluck(:commentable_id)
      @commented_discussions = Genesis::Discussion.joins(:category).find(discussion_comments)
    end

    def set_show_seo_meta
      set_meta_tags title: @member.username,
                    description: "#{@member.username} Profile"
    end

    def set_twitter_meta
      set_meta_tags twitter: {
        card: "summary_large_image",
        title: @member.username,
        description: "#{@member.username} Profile",
        image: {
          _: avatar_thumbnail(@member),
          alt: "#{@member.username}'s Avatar"
        }
      }
    end

    def set_og_meta
      set_meta_tags og: {
        title: @member.username,
        type: "profile",
        url: request.original_url,
        image: {
          _: avatar_thumbnail(@member),
          alt: "#{@member.username}'s Avatar"
        }
      }
    end

    # Not Used
    def set_article_meta; end

    def record_view
      ahoy.track "Viewed Profile",
                 id: @entry.id,
                 username: @entry.username,
                 slug: @entry.slug

      return unless user_signed_in?
      Analytics.track(
        user_id: current_user.id,
        event: "Viewed Profile",
        properties: {
          id: @entry.id,
          username: @entry.username,
          slug: @entry.slug
        }
      )
    end

    def avatar_thumbnail(member)
      if member.profile.respond_to?(:avatar) && member.profile.avatar.nil? == false
        member.profile.avatar
      else
        ActionController::Base.helpers.asset_url("default-avatar.jpg")
      end
    end
end

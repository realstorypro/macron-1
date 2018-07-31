# frozen_string_literal: true

# handles the display of the profile model
class ProfileController < MembersController
  before_action :set_user_to_current
  before_action :preload_entry
  before_action :set_show_seo_meta, :set_twitter_meta, :set_og_meta, :set_article_meta, only: [:show]

  layout "layouts/client"
  def show
    @editable = true
    render "members/show"
  end

  private

    # setting member to the current user
    def set_user_to_current
      @member = current_user
    end

    def preload_entry
      @comments = Comment.where(
        user_id: @member.id,
        commentable_type: %w(Article Discussion Video Podcast)
      ).order("created_at desc")
      @content_ids = @comments.map(&:commentable_id)
      @commented_content = Entry.where(id: @content_ids)
    end

    def record_view
      ahoy.track "Viewed Own Profile",
                 id: @member.id,
                 username: @member.username,
                 slug: @member.slug

      return unless user_signed_in?

      @analytics.track(
        user_id: current_user.id,
        event: "Viewed Own Profile",
        properties: {
          id: @member.id,
          username: @member.username,
          slug: @member.slug
        }
      )
    end

    # overriding the entry to use
    def load_entry
      authorize @entry = current_user.profile
    end
end

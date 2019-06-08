# frozen_string_literal: true

# handles the display of the article model
class MembersController < DisplayController
  layout "layouts/client"
  before_action :preload_entry, only: [:show]
  before_action :set_show_seo_meta, :set_twitter_meta, :set_og_meta, :set_article_meta, only: [:show]
  skip_before_action :find_related_ad, :find_related_content, :set_article_meta

  def index
    # we're not offering an index view
    # we want people to go to members if they try to hit it
    redirect_to root_path
  end

  def show
    @editable = false
  end

  private

    def preload_entry
      @member = User.joins(:profile).friendly.find(params[:id])
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

    def record_view
      track(
        event: "Viewed Profile",
        props: {
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

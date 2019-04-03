# frozen_string_literal: true

# handles the display of the profile model
class ProfileController < MembersController
  skip_before_action :preload_entry

  before_action :set_user_to_current
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
    end

    def record_view
      track(
        event: "Viewed Own Profile",
        props: {
            id: @member.id,
            username: @member.username,
            slug: @member.slug
        }
      )
    end

    # overriding the entry to use
    def load_entry
      redirect_to root_path if current_user.nil?
      authorize @entry = current_user.profile unless current_user.nil?
    end
end

# frozen_string_literal: true

# handles the display of the profile model
class ProfileController < MembersController
  layout "layouts/client"

  def show
    @editable = true
    render "members/show"
  end

  private
    def preload_entry
      @member = current_user
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

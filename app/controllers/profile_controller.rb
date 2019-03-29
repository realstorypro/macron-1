# frozen_string_literal: true
require 'stream'

# handles the display of the profile model
class ProfileController < MembersController
  before_action :set_user_to_current
  # before_action :preload_entry
  before_action :set_show_seo_meta, :set_twitter_meta, :set_og_meta, :set_article_meta, only: [:show]

  layout "layouts/client"
  def show
    @editable = true

    client = Stream::Client.new(ENV["STREAM_API_KEY"], ENV["STREAM_API_SECRET"])
    user_stream = client.feed('user', @member.id)
    @stream_token = user_stream.readonly_token

    enricher = StreamRails::Enrich.new
    feed = StreamRails.feed_manager.get_user_feed(current_user.id)
    results = feed.get()['results']
    @activities = enricher.enrich_activities(results)

    @categories = []
    @categories.push ({name: "Comments", slug: "comments", icon: "comments"})
    @categories.push ({name: "Events", slug: "events", icon: "calendar"})
    @categories.push ({name: "Articles", slug: "articles", icon: "book"})
    @categories.push ({name: "Videos", slug: "videos", icon: "video"})
    @categories.push ({name: "Discussions", slug: "discussions", icon: "pencil alternate"})
    @categories.push ({name: "Podcasts", slug: "podcasts", icon: "podcast"})

    render "members/show"
  end

  private

    # setting member to the current user
    def set_user_to_current
      @member = current_user
    end

    def preload_entry
     #  @comments = Comment.where(
     #    user_id: @member.id,
     #    commentable_type: %w(Article Discussion Video Podcast)
     #  ).order("created_at desc")
     #  @content_ids = @comments.map(&:commentable_id)
     #  @commented_content = Entry.where(id: @content_ids)
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

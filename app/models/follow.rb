# frozen_string_literal: true

class Follow < Socialization::ActiveRecordStores::Follow
  include PublicActivity::Model

  tracked owner: -> (_controller, model) { model.follower }
end

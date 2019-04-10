# frozen_string_literal: true

module Activitible
  extend ActiveSupport::Concern

  included do
    include PublicActivity::Model
    tracked owner: -> (_controller, model) { model.user }
  end
end

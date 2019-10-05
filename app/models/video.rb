# frozen_string_literal: true

class Video < Entry
  include Autoloadable
  include Activitible

  content_attr :embedded_video, :string
  before_save :embed_video

  validates_presence_of :category

  paginates_per 5
end

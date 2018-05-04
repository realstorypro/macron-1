# frozen_string_literal: true

module Seoable
  extend ActiveSupport::Concern

  included do
    content_attr :description, :text
    content_attr :keywords, :text
  end
end

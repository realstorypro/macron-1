# frozen_string_literal: true

class Article < Entry
  include Autoloadable
  include StreamRails::Activity
  as_activity

  validates_presence_of :category

  paginates_per 5

  def activity_extra_data
    {'slug' => self.slug}
  end

  def activity_object
    self.model_name.human
  end

  def activity_verb
    "published"
  end
end

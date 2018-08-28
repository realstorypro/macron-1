class Area < ApplicationRecord
  belongs_to :areable, polymorphic: true, optional: true

  has_many :elements, -> { order(:position) }, as: :elementable, dependent: :destroy

  belongs_to :entry, optional: true

  def self.policy_class
    MetaPolicy
  end
end

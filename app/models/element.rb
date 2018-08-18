class Element < ApplicationRecord
  include Payloadable

  def self.policy_class
    MetaPolicy
  end
end

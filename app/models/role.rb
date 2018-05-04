# frozen_string_literal: true

class Role < ApplicationRecord
  has_and_belongs_to_many :users, join_table: :genesis_users_genesis_roles
  default_scope { order("name") }

  belongs_to :resource,
             polymorphic: true,
             optional: true

  validates :resource_type,
            inclusion: { in: Rolify.resource_types },
            allow_nil: true

  scopify

  # TODO: Move into its own concern
  include SettingsHelper

  before_create :verify_role_exists
  before_update :verify_role_exists

  def verify_role_exists
    roles = settings "auth.roles", fatal_exception: true
    raise "Role: `#{name}` is not defined under auth.roles" unless roles.include?(name)
  end
end

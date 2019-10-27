# frozen_string_literal: true

# rubocop:disable Metrics/LineLength

require "friendly_id"

class User < ApplicationRecord
  # encrypted fields
  encrypts :email
  blind_index :email

  encrypts :phone_number
  blind_index :email_number

  has_merit

  include SettingsHelper
  extend FriendlyId

  # Social & Gamification Concerns
  include User::Supporters
  include User::State

  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  rolify role_cname: "Role", before_add: :clear_existing_roles!
  friendly_id :username, use: :slugged

  # Relationships
  has_many :comments, dependent: :destroy
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  has_many :entries
  has_many :articles
  has_many :videos
  has_many :discussions
  has_many :podcasts
  has_many :events
  has_many :activities, as: :actor

  # Setting Default Scope
  default_scope { includes(:profile).joins(:profile) }

  # Accessors
  attr_accessor :login
  attr_accessor :newsletter
  attr_accessor :admin_applying_update

  # Callbacks
  after_create :add_subscription
  after_create :assign_default_role!
  before_create :build_profile
  after_update :broadcast_activity


  # Validations
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validate :validate_username
  validates_presence_of :username, :slug, :email

  # Adding Alias
  alias_attribute :name, :username

  acts_as_followable
  acts_as_follower

  # Gamification
  acts_as_voter

  # Phone Number Validations
  validates_presence_of :country
  before_validation :format_phone_number

  # the account is created without a phone number
  # we only want to validate presence on the update
  # unless the update is performed by an admin
  validates_presence_of :phone_number, on: :update, unless: -> { defined?(admin_applying_update) && admin_applying_update == true }

  # we are checking for an areacode + phone number uniquness
  # in the future we may have to allow for the same phone number
  # and area code to be in different countries
  # currently its an edge case and were not worrying about it
  validates_uniqueness_of :phone_number, allow_blank: true, allow_nil: true

  # we want to make sure that the number is valid mobile number
  # for the country carrier
  validates :phone_number, phone: { allow_blank: true,
                                    possible: :true,
                                    country_specifier: ->(phone) { phone.country.try(:upcase) } }

  # un-verifies phone number if phone or country has changed
  before_save :unverify_phone_if_changed

  paginates_per 10

  def format_phone_number
    # return true if there the number is blank and we have nothing to format
    return true if phone_number.blank?

    # strip out all non numeric characters
    numeric_phone = phone_number.gsub(/\D/, "")

    # remove the country code if the user typed it in
    self.phone_number = Phonelib.parse(numeric_phone, country).national(false)
  end

  def add_subscription
    return unless newsletter == "1"
    Zapier::NewsletterSubscription.new(self).post_to_zapier
  end

  def validate_username
    errors.add(:username, :invalid) if User.where(email: username).exists?
  end

  def unverify_phone_if_changed
    self.phone_verified = false if phone_number_changed? || country_changed?
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(email: login).or(self.where(username: login)).first
    elsif conditions[:username].nil?
      where(conditions).first
    else
      where(username: conditions[:username]).first
    end
  end

  def assign_default_role!
    default_role = settings("defaults.permissions.new_user.role", fatal_exception: true).to_sym
    add_role(default_role) if roles.blank?
  end

  # removes all roles before new role is added
  def clear_existing_roles!(_role = nil)
    self.roles = []
  end

  # returns the first role out of an array
  def role
    return roles.first.name unless roles.first.nil?
    "guest"
  end

  def ban!
    # for some reason the add_role isn't trigger role cleanup
    # now we're running role_cleanup manually
    clear_existing_roles!
    profile.erase_profile!
    add_role :banned
  end

  def unban!
    # for some reason the add_role isn't trigger role cleanup
    # now we're running role_cleanup manually
    clear_existing_roles!
    assign_default_role!
  end

  def verify_profile!
    profile.verify!
  end

  def unverify_profile!
    profile.unverify!
  end

  def enable_help!
    self.help = true
    save
  end

  def disable_help!
    self.help = false
    save
  end

  def enable_advanced!
    self.advanced = true
    save
  end

  def disable_advanced!
    self.advanced = false
    save
  end

  def can_manage?(component)
    roles.each do |role|
      return true if settings("auth.permissions.#{role.name}.#{component}").methods.include?(:all)
    end
    false
  end

  def self.policy_class
    UserPolicy
  end

  def broadcast_activity
    ActionCable.server.broadcast("user_#{self.id}", user_id: self.id)
  end
end
# rubocop:enable Metrics/LineLength

# frozen_string_literal: true

require "friendly_id"

class User < ApplicationRecord
  has_merit

  include SettingsHelper
  extend FriendlyId

  # Social & Gamification Concerns
  include User::Supporters
  include User::State

  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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

  # Callbacks
  after_create :add_subscription
  after_create :assign_default_role!
  before_create :build_profile
  before_save :unverify_phone?
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

  # Phone Number & Country Codes
  before_save :format_phone_number, on: :update
  validates_presence_of :country, :phone_number, on: :update
  validates :phone_number, phone: { allow_blank: true,
                                    types: :mobile,
                                    country_specifier: ->(phone) { phone.country.try(:upcase) } }

  paginates_per 10

  def format_phone_number
    numeric_phone = phone_number.gsub(/\D/, "")
    self.phone_number = Phonelib.parse(numeric_phone, country).national(false)
  end

  def add_subscription
    return unless newsletter == "1"
    Zapier::NewsletterSubscription.new(self).post_to_zapier
  end

  def validate_username
    errors.add(:username, :invalid) if User.where(email: username).exists?
  end

  # un-verifies phone number if phone or country has changed
  def unverify_phone?
    self.phone_verified = false if phone_number_changed? || country_changed?
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions).where(["username = :value OR lower(email) = lower(:value)", { value: login }]).first
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

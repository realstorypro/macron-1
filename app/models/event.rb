# frozen_string_literal: true

class Event < Entry
  include Autoloadable

  before_save :cleanup_ticket_url

  validates_presence_of :category
  validates :ticket_link, url: true
  validate :approved_ticket_provider

  paginates_per 5

  def approved_ticket_provider
    services = %w[picatic]
    return true if services.any? { |service| ticket_link.include? service }
    errors.add(:audio, "Only Picatic URLs are allowed")
  end

  def cleanup_ticket_url
    if ticket_link.include?("picatic")
      ticket_slug = ticket_link.split('/').last
      unless is_number?(ticket_slug)
        resp = HTTParty.get( "https://api.picatic.com/v2/event/#{ticket_slug}" )
        self.ticket_link = "https://www.picatic.com/#{resp.parsed_response["data"]["id"]}"
      end
    end
  end

  private

  def is_number? string
    true if Float(string) rescue false
  end

end

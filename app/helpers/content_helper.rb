# frozen_string_literal: true

module ContentHelper
  include HTTParty

  # returns the formatted verison of the content
  def format_content (content)

    # scan for embeds
    embeds = content.scan(/\[embed]([^<>]*)\[\/embed\]/).flatten
    embeds.each do |embed|

    end

    # building embeds
    # urls = URI.extract(content)
    # excluded_urls = %w(ucarecdn)
    # embeddable_urls = []
    # embeddable_array = []

    # urls.each do |url|
    #   # excluded the urls we don't want embedded
    #   excluded_urls.each do |excluded|
    #     embeddable_urls << url unless url.include?(excluded)
    #   end
    # end

    # embeddable_urls.each do |embeddable|
    #   parsed_response = HTTParty.get("https://iframe.ly/api/iframely?url=#{embeddable}&api_key=#{ENV['IFRAMELY_API']}").parsed_response["html"]
    #   embeddable_array << [embeddable, parsed_response] if parsed_response
    # end

    # embeddable_array.each do |embed|
    #   content.gsub!(embed[0], embed[1])
    # end


    #content
    #content.html_safe
  end
end

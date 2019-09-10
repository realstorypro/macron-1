# frozen_string_literal: true

module ContentHelper
  include HTTParty

  # returns the formatted verison of the content
  def format_content (content)

    # scan for embeds
    # embeds = content.scan(/\[embed]([^<>]*)\[\/embed\]/).flatten
    embeds.each do |embed|
      parsed_response = HTTParty.get("https://iframe.ly/api/iframely?url=#{embed}&api_key=#{ENV['IFRAMELY_API']}").parsed_response["html"]
      if parsed_response
        content.gsub!("[embed]#{embed}[/embed]", parsed_response)
      else
        content.gsub!("[embed]#{embed}[/embed]", "<h4>Embed Unavailable</h4>")
      end
    end

    content.html_safe
  end
end

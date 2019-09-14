# frozen_string_literal: true

module ContentHelper
  include HTTParty

  # returns the formatted verison of the content
  def format_content (content)

    # scan for embeds
    embeds = content.scan(/\[embed]([^<>]*)\[\/embed\]/).flatten
    embeds.each do |embed|
      parsed_response = HTTParty.get("https://iframe.ly/api/iframely?url=#{embed}&api_key=#{ENV['IFRAMELY_API']}").parsed_response["html"]
      if parsed_response
        content.gsub!("[embed]#{embed}[/embed]", "<div class='embed'>#{parsed_response}</div>")
      else
        content.gsub!("[embed]#{embed}[/embed]", "<h4>Embed Unavailable</h4>")
      end
    end

    # replace hr with semantic ui divs
    content.gsub!("<hr>",'<div class="ui divider"></div>')

    content.html_safe
  end
end

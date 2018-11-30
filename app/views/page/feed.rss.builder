# frozen_string_literal: true

xml.instruct! :xml, version: "1.0"

xml.rss version: "2.0" do
  xml.channel do
    xml.title ss("general.name")
    xml.description ss("general.description")
    xml.link root_url
    @entries.each do |entry|
      xml.item do
        xml.title entry.name
        xml.description entry.description
        xml.category entry.category.name
        xml.pubDate Time.new(entry.published_date.year, entry.published_date.month, entry.published_date.day).to_formatted_s(:rfc822)
        xml.link entry_url(entry)
        xml.guid entry_url(entry)
      end
    end
  end
end

xml.instruct! :xml, :version => "1.0"

xml.rss :version => "2.0" do
  xml.channel do
    xml.title "My Company Blog"
    xml.description "This is a blog by My Company"
    xml.link root_url
    @entries.each do |entry|
      xml.item do
        xml.title entry.name
        xml.description entry.description
        xml.type entry.type
        xml.category entry.category.name
        xml.pubDate entry.published_date.to_s(:rfc822) unless entry.published_date.nil?  end
        xml.link entry_url(entry)
        xml.guid entry_url(entry)
    end
  end
end

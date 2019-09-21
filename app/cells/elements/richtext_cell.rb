# frozen_string_literal: true

module Elements
  class RichtextCell < BaseElementCell
    def formatted_text
      model.rich.gsub!("<ul>","<ul class='ui list'>")
      model.rich.gsub!("<ol>","<ol class='ui list'>")
      model.rich
    end
  end
end

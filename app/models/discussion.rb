# frozen_string_literal: true

class Discussion < Entry
  include Autoloadable
  include Activitible

  validates_presence_of :category
  paginates_per 25

  content_attr :menu_color, :string

  after_touch :update_menu_color

  # setting menu color to black unless
  # the first header has a color assigned to it
  def update_menu_color
    area_found = false
    self.areas.each do |area|
      unless area_found
        if area.type == "Areas::Header"
          if area.elements.first.nil?
            area_found = true
            self.menu_color = "black"
            self.save
          else
            area_color = area.elements.first.color

            if area_color
              self.menu_color = area_color
            else
              self.menu_color = "black"
            end

            area_found = true
            self.save
          end
        end
      end
    end
  end
end

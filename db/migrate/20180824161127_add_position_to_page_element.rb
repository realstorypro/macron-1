class AddPositionToPageElement < ActiveRecord::Migration[5.2]
  def change
    add_column :page_elements, :position, :integer
  end
end

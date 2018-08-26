class DropPageElements < ActiveRecord::Migration[5.2]
  def change
    drop_table :page_elements
  end
end

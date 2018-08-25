class RemovePageIdFromPageElements < ActiveRecord::Migration[5.2]
  def change
    remove_column :page_elements, :page_id
  end
end

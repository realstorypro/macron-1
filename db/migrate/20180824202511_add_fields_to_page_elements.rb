class AddFieldsToPageElements < ActiveRecord::Migration[5.2]
  def change
    add_column :page_elements, :elementable_id, :integer
    add_column :page_elements, :elementable_type, :string
  end
end

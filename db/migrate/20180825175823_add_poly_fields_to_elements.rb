class AddPolyFieldsToElements < ActiveRecord::Migration[5.2]
  def change
    add_column :elements, :elementable_id, :integer
    add_column :elements, :elementable_type, :string
    add_column :elements, :position, :integer
  end
end

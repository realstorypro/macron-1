class RemoveNameFromElements < ActiveRecord::Migration[5.2]
  def change
    remove_column :elements, :name
  end
end

class RemoveAreasFromElements < ActiveRecord::Migration[5.2]
  def change
    remove_column :elements, :areas
  end
end

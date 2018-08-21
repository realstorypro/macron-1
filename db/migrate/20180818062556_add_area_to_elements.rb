class AddAreaToElements < ActiveRecord::Migration[5.2]
  def change
    add_column :elements, :areas, :jsonb
  end
end

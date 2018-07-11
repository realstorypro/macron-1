class AddTypeToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :type, :string
  end
end

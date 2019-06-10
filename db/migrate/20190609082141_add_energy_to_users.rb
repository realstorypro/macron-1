class AddEnergyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :energy, :integer, default: 0
  end
end

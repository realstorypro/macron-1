class AddModesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :help, :boolean
    add_column :users, :advanced, :boolean
  end
end

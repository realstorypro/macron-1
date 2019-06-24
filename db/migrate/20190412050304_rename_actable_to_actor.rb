class RenameActableToActor < ActiveRecord::Migration[5.2]
  def change
    rename_column :activities, :actable_type, :actor_type
    rename_column :activities, :actable_id, :actor_id
  end
end

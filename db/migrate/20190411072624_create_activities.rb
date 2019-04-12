class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    drop_table :activities
    create_table :activities do |t|
      t.references :actable, polymorphic: true, index:true
      t.references :subjectable, polymorphic: true, index:true
      t.json :payload
      t.timestamps
    end
  end
end

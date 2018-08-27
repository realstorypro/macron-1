class CreateAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :areas do |t|
      t.string :type
      t.integer :areable_id
      t.string :areable_type
      t.timestamps
    end
  end
end

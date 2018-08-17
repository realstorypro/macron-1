class CreateComponents < ActiveRecord::Migration[5.2]
  def change
    create_table :components do |t|
      t.string :name
      t.boolean :enabled

      t.timestamps
    end
  end
end

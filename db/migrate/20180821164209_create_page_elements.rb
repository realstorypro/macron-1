class CreatePageElements < ActiveRecord::Migration[5.2]
  def change
    create_table :page_elements do |t|
      t.references :page, foreign_key: true
      t.references :element, foreign_key: true

      t.timestamps
    end
  end
end

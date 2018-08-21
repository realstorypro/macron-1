class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.string :name
      t.string :slug
      t.jsonb :structure
      t.date :published_date

      t.timestamps
    end
  end
end

class AddPayloadToPages < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :payload, :jsonb
  end
end

class Bypass2fa < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bypass2fa, :boolean, default: false
  end
end

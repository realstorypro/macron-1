class AddDefaultCountryToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :country,:string, default: "us"
  end
end

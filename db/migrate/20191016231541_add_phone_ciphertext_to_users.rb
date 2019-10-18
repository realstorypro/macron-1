class AddPhoneCiphertextToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :phone_number_ciphertext, :string

    # blind index
    add_column :users, :phone_number_bidx, :string
    add_index :users, :phone_number_bidx, unique: true
  end
end

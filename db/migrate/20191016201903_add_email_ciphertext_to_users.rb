class AddEmailCiphertextToUsers < ActiveRecord::Migration[5.2]
  def change
    # encrypted data
    add_column :users, :email_ciphertext, :string

    # blind index
    add_column :users, :email_bidx, :string
    add_index :users, :email_bidx, unique: true

    # drop original here unless we have existing users
    remove_column :users, :email
  end
end

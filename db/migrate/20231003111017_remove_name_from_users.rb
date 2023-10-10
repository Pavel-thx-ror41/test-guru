class RemoveNameFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :name, :string
    remove_column :users, :password_reset_token, :string
    remove_column :users, :info, :text
    change_column :users, :password_digest, :string, null: true
  end
end

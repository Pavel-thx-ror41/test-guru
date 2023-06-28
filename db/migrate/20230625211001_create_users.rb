class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, limit: 30
      t.string :name, limit: 30
      t.string :password_digest
      t.string :password_reset_token
      t.text :info, limit: 512

      t.timestamps
    end
    add_index :users, :password_reset_token, unique: true
    add_index :users, :email, unique: true
    add_index :users, :name, unique: true
  end
end

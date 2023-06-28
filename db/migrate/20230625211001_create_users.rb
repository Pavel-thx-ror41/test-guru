class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.string :password_digest, null: false
      t.string :password_reset_token
      t.text :info

      t.timestamps

      t.index [:email], name: :index_users_on_email, unique: true
      t.index [:name], name: :index_users_on_name, unique: true
      t.index [:password_reset_token], name: :index_users_on_password_reset_token, unique: true
    end
  end
end

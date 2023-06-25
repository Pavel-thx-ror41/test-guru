class BlockNulls < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:users, :name, false)
    change_column_null(:users, :email, false)
    change_column_null(:users, :password_digest, false)
    change_column_null(:tests, :title, false)
    change_column_null(:questions, :title, false)
    change_column_null(:categories, :title, false)
    change_column_null(:answers, :title, false)
  end
end

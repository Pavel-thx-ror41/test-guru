class BlockNullsInInfoColumns < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :info, false
    change_column_null :categories, :info, false
    change_column_null :tests, :info, false
    change_column_null :questions, :info, false
    change_column_null :answers, :info, false
  end
end

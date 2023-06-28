class CreateTests < ActiveRecord::Migration[6.1]
  def change
    create_table :tests do |t|
      t.integer :user_id, null: false
      t.integer :category_id, null: false
      t.boolean :published, default: false
      t.integer :level, default: 1, null: false
      t.string :title, null: false
      t.text :info

      t.timestamps

      t.index [:user_id], name: :index_tests_on_user_id
      t.index [:category_id], name: :index_tests_on_category_id
      t.index [:title], name: :index_tests_on_title, unique: true
    end

    add_foreign_key :tests, :users
    add_foreign_key :tests, :categories
  end
end

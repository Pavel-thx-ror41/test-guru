class CreateTests < ActiveRecord::Migration[6.1]
  def change
    create_table :tests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.boolean :published, default: false, null: false
      t.integer :level, default: 1, null: false
      t.string :title, null: false
      t.text :info

      t.timestamps

      t.index [:title], name: :index_tests_on_title, unique: true
    end
  end
end

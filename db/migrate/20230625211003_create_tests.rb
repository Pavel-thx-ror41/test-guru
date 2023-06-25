class CreateTests < ActiveRecord::Migration[6.1]
  def change
    create_table :tests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.boolean :published
      t.string :title, limit: 30
      t.text :info, limit: 512

      t.timestamps
    end
    add_index :tests, :title, unique: true
  end
end

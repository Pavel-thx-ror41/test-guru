class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :title, null: false
      t.text :info

      t.timestamps

      t.index [:title], name: :index_categories_on_title, unique: true
    end
  end
end

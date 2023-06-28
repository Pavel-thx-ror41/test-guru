class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.references :test, null: false, foreign_key: true
      t.string :title, limit: 30
      t.text :info, limit: 512

      t.timestamps
    end
    add_index :questions, :title, unique: true
  end
end

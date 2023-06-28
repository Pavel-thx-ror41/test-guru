class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.integer :test_id, null: false
      t.string :title, null: false
      t.text :info

      t.timestamps

      t.index [:test_id], name: :index_questions_on_test_id
      t.index [:title], name: :index_questions_on_title, unique: true
    end

    add_foreign_key :questions, :tests
  end
end

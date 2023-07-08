class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.references :test, null: false, foreign_key: true
      t.string :title, null: false
      t.text :info, null: false

      t.timestamps

      t.index [:title], name: :index_questions_on_title, unique: true
    end
  end
end

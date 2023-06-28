class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.integer :question_id, null: false
      t.boolean :correct, default: false, null: false
      t.string :title, null: false
      t.text :info

      t.timestamps

      t.index [:question_id], name: :index_answers_on_question_id
      t.index [:title], name: :index_answers_on_title, unique: true
    end
    add_foreign_key :answers, :questions
  end
end

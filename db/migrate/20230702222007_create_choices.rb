class CreateChoices < ActiveRecord::Migration[6.1]
  def change
    create_table :choices do |t|
      t.references :pass, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :answer, null: false, foreign_key: true

      t.timestamps

      t.index ["pass_id", "question_id", "answer_id"], name: "index_choices_on_pass_id_and_question_id_and_answer_id", unique: true
    end
  end
end

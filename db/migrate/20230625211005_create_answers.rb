class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.references :question, null: false, foreign_key: true
      t.boolean :correct, default: false, null: false
      t.string :title, null: false
      t.text :info

      t.timestamps

      t.index [:title], name: :index_answers_on_title, unique: true
    end
  end
end

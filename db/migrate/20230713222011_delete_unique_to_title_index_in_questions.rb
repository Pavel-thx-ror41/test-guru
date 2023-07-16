class DeleteUniqueToTitleIndexInQuestions < ActiveRecord::Migration[6.1]
  def change
    remove_index :questions, name: :index_questions_on_title
    add_index :questions, [:title], name: :index_questions_on_title, unique: false
    # t.index [:title], name: :index_questions_on_title, unique: false
  end
end

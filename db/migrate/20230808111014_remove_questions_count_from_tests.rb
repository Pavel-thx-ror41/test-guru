class RemoveQuestionsCountFromTests < ActiveRecord::Migration[6.1]
  def change
    remove_column :tests, :questions_count
  end
end

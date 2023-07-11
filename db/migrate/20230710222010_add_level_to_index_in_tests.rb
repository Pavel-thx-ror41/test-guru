class AddLevelToIndexInTests < ActiveRecord::Migration[6.1]
  def change
    add_index :tests, [:title, :level], name: :index_tests_on_title_and_level, unique: true
    # t.index [:title, :level], name: :index_tests_on_title_and_level, unique: true
    remove_index :tests, name: "index_tests_on_title"
  end
end

class AddColumnLevelToTests < ActiveRecord::Migration[6.1]
  def change
    add_column(:tests, :level, :integer, default: 1, null: false)
  end
end

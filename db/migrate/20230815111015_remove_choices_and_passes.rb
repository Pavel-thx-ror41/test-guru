class RemoveChoicesAndPasses < ActiveRecord::Migration[6.1]
  def change
    drop_table :choices, if_exists: true
    drop_table :passes, if_exists: true
  end
end

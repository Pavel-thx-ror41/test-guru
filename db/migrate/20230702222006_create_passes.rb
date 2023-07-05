class CreatePasses < ActiveRecord::Migration[6.1]
  def change
    create_table :passes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :test, null: false, foreign_key: true
      t.datetime :pass_start, precision: 6, null: false

      t.timestamps
    end
    # add_index :passes, %i[user_id test_id], unique: false
  end
end

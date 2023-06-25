class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.references :question, null: false, foreign_key: true
      t.string :title, limit: 30
      t.boolean :correct
      t.text :info, limit: 512

      t.timestamps
    end
    add_index :answers, :title, unique: true
  end
end

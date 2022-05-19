class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :artist
      t.string :capo

      t.timestamps
    end
  end
end

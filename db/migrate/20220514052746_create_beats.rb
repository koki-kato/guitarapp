class CreateBeats < ActiveRecord::Migration[6.1]
  def change
    create_table :beats do |t|
      t.references :score, null: false, foreign_key: true
      t.string :lyric
      t.string :image_name

      t.timestamps
    end
  end
end

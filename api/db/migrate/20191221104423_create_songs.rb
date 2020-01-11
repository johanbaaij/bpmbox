class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :track
      t.string :side
      t.references :artist, null: true, foreign_key: true
      t.references :release, null: true, foreign_key: true
      t.decimal :bpm
      t.integer :key

      t.timestamps
    end
  end
end

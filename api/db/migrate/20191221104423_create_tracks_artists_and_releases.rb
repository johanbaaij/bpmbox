class CreateTracksArtistsAndReleases < ActiveRecord::Migration[6.0]
  def change
    create_table :releases do |t|
      t.string :title

      t.timestamps
    end

    create_table :artists do |t|
      t.string :name

      t.timestamps
    end

    create_table :tracks do |t|
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

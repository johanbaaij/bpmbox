class CreateTracksArtistsAndReleases < ActiveRecord::Migration[6.0]
  def change
    create_table :artists, id: :uuid do |t|
      t.string :name

      t.timestamps
    end

    create_table :releases, id: :uuid do |t|
      t.string :title
      t.string :artist

      t.timestamps
    end

    create_table :tracks, id: :uuid do |t|
      t.string :title
      t.string :position
      t.decimal :bpm
      t.integer :key
      t.integer :duration
      t.references :artist, null: true, foreign_key: true, type: :uuid
      t.references :release, null: true, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

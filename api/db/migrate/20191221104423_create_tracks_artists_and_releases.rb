class CreateTracksArtistsAndReleases < ActiveRecord::Migration[6.0]
  def change
    create_table :artists, id: :uuid do |t|
      t.string :name

      t.timestamps
    end

    create_table :releases, id: :uuid do |t|
      t.string :title
      t.string :artist
      t.jsonb :discogs_response
      t.bigint :discogs_release_id
      t.datetime :imported_at

      t.timestamps
    end

    create_table :tracks, id: :uuid do |t|
      t.string :position
      t.string :title
      t.string :artist
      t.jsonb :spotify_response
      t.decimal :bpm
      t.integer :duration
      t.integer :key
      t.datetime :imported_at
      t.references :release, null: true, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :releases, :discogs_release_id

  end
end

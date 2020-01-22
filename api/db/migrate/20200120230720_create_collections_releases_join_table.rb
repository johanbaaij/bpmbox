# frozen_string_literal: true

class CreateCollectionsReleasesJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :collections_releases, id: false do |t|
      t.references :collection, type: :uuid, foreign_key: true
      t.references :release, type: :uuid, foreign_key: true
      t.bigint :discogs_instance_id
    end
    add_index :collections_releases, :discogs_instance_id, unique: true
  end
end

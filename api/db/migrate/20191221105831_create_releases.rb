class CreateReleases < ActiveRecord::Migration[6.0]
  def change
    create_table :releases do |t|
      t.string :title
      t.references :artist, null: true, foreign_key: true

      t.timestamps
    end
  end
end

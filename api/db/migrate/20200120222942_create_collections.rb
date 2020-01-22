class CreateCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :collections, id: :uuid do |t|
      t.string :username
      t.references :user, null: true, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :collections, :username, unique: true

  end
end

# frozen_string_literal: true

class CreateReleasesUsersJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :releases_users, id: false do |t|
      t.references :release, type: :uuid, foreign_key: true
      t.references :user, type: :uuid, foreign_key: true
    end
    add_index :releases_users, %i[release_id user_id], unique: true
  end
end

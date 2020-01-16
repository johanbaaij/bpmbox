class CreateReleasesUsersJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :releases_users, id: false do |t|
      t.references :user, type: :uuid
      t.references :release, type: :uuid
    end
  end
end

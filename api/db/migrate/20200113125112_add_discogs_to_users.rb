class AddDiscogsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :discogs_request_token, :jsonb
    add_column :users, :discogs_access_token, :jsonb
  end
end

class CollectionRelease < ActiveRecord::Base
  self.table_name = "collections_releases"
  belongs_to :collection
  belongs_to :release
  after_commit :fetch_tracks, on: :create

  def fetch_tracks
    ImportDiscogsReleaseJob.perform_async(
      release.discogs_release_id,
      collection.username
    )
  end
end
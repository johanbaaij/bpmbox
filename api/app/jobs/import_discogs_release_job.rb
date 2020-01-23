# frozen_string_literal: true

class ImportDiscogsReleaseJob
  include Sidekiq::Worker
  include Sidekiq::Throttled::Worker
  sidekiq_options queue: :discogs

  sidekiq_throttle(
    concurrency: { limit: 1 },
    threshold: { limit: 1, period: 5.seconds }
  )

  def perform(release_id)
    @release_id = release_id
    @release = Release.find_by(discogs_release_id: release_id)
    response = fetch_api_release

    unless response.resource_url && response.id
      raise "#{response}"
    end

    hash_release = Discogs::Responses::Release.new(response).to_release
    @release.tracks << hash_release.tracks
  end

  def fetch_api_release
    api = Discogs::Api.new
    api.get_release(@release_id)
  end
end

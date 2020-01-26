# frozen_string_literal: true

class ImportDiscogsReleaseJob
  include Sidekiq::Worker
  include Sidekiq::Throttled::Worker
  sidekiq_options queue: :discogs

  sidekiq_throttle(
    concurrency: { limit: 1 },
    threshold: { limit: 1, period: 3.seconds }
  )

  def perform(release_id, username)
    @release_id = release_id
    find_release
    fetch_discogs_release
    add_extra_data_to_release
    ImportSpotifyAudioFeaturesJob.perform_async(@release_id, username)
  end

  def find_release
    @release = Release.find_by(discogs_release_id: @release_id)
    raise 'Release not found' unless @release.present?
  end

  def fetch_discogs_release
    @response = Discogs::Api.new.get_release(@release_id)
    raise @response.to_s unless @response.resource_url && @response.id
  end

  def add_extra_data_to_release
    release = Discogs::Responses::Release
              .new(@response)
              .to_release
    release.save
  end
end

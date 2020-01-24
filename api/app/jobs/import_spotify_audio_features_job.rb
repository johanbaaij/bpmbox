# frozen_string_literal: true

class ImportSpotifyAudioFeaturesJob
  include Sidekiq::Worker
  include Sidekiq::Throttled::Worker
  sidekiq_options queue: :spotify

  sidekiq_throttle(
    concurrency: { limit: 1 },
    threshold: { limit: 100, period: 1.minute }
  )

  def perform(release_id)
    release = Release.find_by(discogs_release_id: release_id)

    track_audio_features = {}
    track_ids = []

    release.tracks.each do |track|
      a = track.artist.dup
      t = track.title.dup
      search_result = RSpotify::Base.search("#{a} - #{t}", 'track'.dup).first
      unless search_result.nil?
        track_audio_features[track.id] = {}
        track_audio_features[track.id]["search_result"] = search_result
        track_ids << search_result.id
      end
    end

    audio_features = RSpotify::AudioFeatures.find(track_ids)

    track_audio_features.keys.each do |key|
      track = track_audio_features[key]
      track_audio_features[key]["spotify_response"] = audio_features.find{ |af| af.id == track["search_result"].id }
      track_audio_features[key]["bpm"] = track_audio_features[key]["spotify_response"].tempo
      track_audio_features[key]["key"] = track_audio_features[key]["spotify_response"].key
      track_audio_features[key]["imported_at"] = DateTime.now
      track.delete("search_result")
    end

    Track.update(track_audio_features.keys, track_audio_features.values)
  end
end

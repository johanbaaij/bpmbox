# frozen_string_literal: true

class Track < ApplicationRecord
  attr_accessor :artist_txt
  belongs_to :artist, optional: true
  belongs_to :release, optional: true
  after_initialize :find_spotify_track

  def find_spotify_track
    track = Spotify::Api.new.search("#{artist_txt} - #{title}", "track")
    return unless track

    audio_features = Spotify::Api.new.audio_features(track.id)
    self.bpm = audio_features.tempo
  end
end

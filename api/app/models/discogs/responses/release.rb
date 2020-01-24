# frozen_string_literal: true

module Discogs
  module Responses
    class Release
      def initialize(hash)
        raise 'Needs to be a Hashie::Mash' unless hash.class == Hashie::Mash

        @hash = hash
      end

      def to_release
        @release = ::Release.find_or_initialize_by(
          discogs_release_id: @hash.id
        )

        @release.title = title
        @release.artist = artist
        @release.tracks = tracks
        @release.discogs_release_id = @hash.id
        @release.discogs_response = @hash
        @release.imported_at = DateTime.now

        @release
      end

      def title
        @hash.title
      end

      def artist
        @hash.artists_sort
      end

      def tracks
        return [] if @hash.tracklist.nil?

        @hash.tracklist.map do |track_hash|
          Track.new(track_hash).to_track
        end
      end
    end
  end
end

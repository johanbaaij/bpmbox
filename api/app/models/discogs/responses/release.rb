# frozen_string_literal: true

module Discogs
  module Responses
    class Release
      def initialize(hash)
        if hash.class == Hashie::Mash
          @hash = hash
        else
          raise 'Needs to be a Hashie::Mash'
        end
      end

      def to_release
        @release = ::Release.new
        @release.title = title
        @release.artist = artist_txt
        @release.tracks = tracks
        @release.discogs_id = discogs_id
        @release
      end

      def title
        @hash.title
      end

      def artist_txt
        @hash.artists.map do |artist|
          "#{artist.name} #{artist.join} "
        end.join.strip
      end

      def tracks
        return [] if @hash.tracklist.nil?

        @hash.tracklist.map do |track_hash|
          Track.new(track_hash, artist_txt).to_track
        end
      end

      def discogs_id
        @hash.id
      end
    end
  end
end

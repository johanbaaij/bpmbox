# frozen_string_literal: true

module Discogs
  module Responses
    class Track
      def initialize(hash, artist_txt)
        @hash = hash
        @artist_txt = artist_txt
      end

      def to_track
        ::Track.new(
          id: SecureRandom.uuid,
          artist_txt: artist,
          title: @hash.title,
          position: @hash.position,
          duration: duration_in_seconds
        )
      end

      protected

      def duration_in_seconds
        minutes = @hash.duration.split(':')[0].to_i
        seconds = @hash.duration.split(':')[1].to_i
        (minutes * 60) + seconds
      end

      def artist
        if @hash.artists.present?
          @hash.artists.map do |artist|
            "#{artist.name} #{artist.join} "
          end.join.strip
        else
          @artist_txt
        end
      end
    end
  end
end

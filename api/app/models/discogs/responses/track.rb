module Discogs
  module Responses
    class Track
      def initialize(hash)
        @hash = hash
      end

      def to_track
        ::Track.new(
          title: @hash.title,
          position: @hash.position,
          duration: duration_in_seconds
        )
      end

      protected

      def duration_in_seconds
        minutes = @hash.duration.split(":")[0].to_i
        seconds = @hash.duration.split(":")[1].to_i
        (minutes * 60) + seconds
      end
    end
  end
end
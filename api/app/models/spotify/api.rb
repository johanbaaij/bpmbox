# frozen_string_literal: true

module Spotify
  class Api
    def search(query, type)
      Rails.cache.fetch("#{type}/#{query}") do
        # Because RSpotify performs clean up on the type argument we
        # duplicate it so it's not a frozen string.
        t = type.dup

        RSpotify::Base.search(query, t).first
      end
    end

    def audio_features(id)
      Rails.cache.fetch("audio_feature/#{id}") do
        RSpotify::AudioFeatures.find(id)
      end
    end
  end
end

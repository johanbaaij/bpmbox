# frozen_string_literal: true

class TrackSerializer
  include FastJsonapi::ObjectSerializer
  attributes :duration, :bpm, :position, :title, :artist

  attribute :release do |track|
    track.release.title
  end
end

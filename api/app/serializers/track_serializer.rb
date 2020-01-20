# frozen_string_literal: true

class TrackSerializer
  include FastJsonapi::ObjectSerializer
  attributes :duration, :bpm, :position, :title, :artist_txt
end

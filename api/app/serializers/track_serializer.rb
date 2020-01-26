# frozen_string_literal: true

class TrackSerializer
  include FastJsonapi::ObjectSerializer
  attributes :duration, :key, :bpm, :position, :title, :artist
  attribute :collection do |_object, params|
    params[:username]
  end

  belongs_to :release
end

# frozen_string_literal: true

class ReleaseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :artist, :title
  has_many :tracks
end

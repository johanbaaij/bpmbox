# frozen_string_literal: true

class ReleaseSerializer
  include FastJsonapi::ObjectSerializer
  set_id :discogs_id
  attributes :artist, :title
  has_many :tracks
end

# frozen_string_literal: true

class Track < ApplicationRecord
  include SortByNullsLast
  belongs_to :release, optional: true
  sort_by_nulls_last :bpm, :key, :position
  scope :sort_by_release_with_position_asc, -> { order('releases.title asc, position asc') }
  scope :sort_by_release_with_position_desc, -> { order('releases.title desc, position asc') }

  def artist
    self[:artist] || release.artist
  end
end

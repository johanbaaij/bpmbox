# frozen_string_literal: true

class Track < ApplicationRecord
  include SortByNullsLast
  belongs_to :release, optional: true
  sort_by_nulls_last :bpm, :key, :position
  scope :sort_by_r_title_positions_asc, -> { order('releases.title asc, position asc') }
  scope :sort_by_r_title_positions_desc, -> { order('releases.title desc, position asc') }
  scope :sort_by_r_artist_positions_asc, -> { order('releases.artist asc, releases.title asc, position asc') }
  scope :sort_by_r_artist_positions_desc, -> { order('releases.artist desc, releases.title desc, position asc') }
end
